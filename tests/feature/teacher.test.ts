import supertest from "supertest";
import app from "../../src";
import { User } from "@prisma/client";
import prisma from "../../src/database";

const generateToken = async (role: string, userId?: string) => {
    return role === "Admin" ? "mock-admin-token" : `mock-teacher-token-${userId}`;
};

const createTestUser = async (roleName: string, overrides: Partial<User> = {}) => {
    const role = await prisma.role.findFirst({ where: { name: roleName } });
    if (!role) throw new Error(`Role '${roleName}' not found`);
    return await prisma.user.create({
        data: {
            name: "Test User",
            email: `test-${Date.now()}@example.com`,
            username: `testuser-${Date.now()}`,
            roleId: role.id,
            password: "password",
            profileImage: "http://example.com/profile.jpg",
            ...overrides,
        },
    });
};

beforeAll(async () => {
    await prisma.role.createMany({
        data: [
            { name: "Admin" },
            { name: "Teacher" },
        ],
        skipDuplicates: true,
    });
});

afterAll(async () => {
    await prisma.user.deleteMany({});
    await prisma.role.deleteMany({});
});

describe("Feature Guru", () => {
    describe("Role: Admin", () => {
        let adminToken: string;
        let teacherRole: any;

        beforeAll(async () => {
            adminToken = await generateToken("Admin");
            teacherRole = await prisma.role.findFirst({ where: { name: "Teacher" } });
        });

        beforeEach(async () => {
            await prisma.user.deleteMany({}); // Clean users before each test
        });

        describe("GET /api/v1/teachers", () => {
            it("Harus mengembalikan daftar guru berupa nama dan email dengan pagination 10", async () => {
                for (let i = 0; i < 15; i++) {
                    await createTestUser("Teacher", {
                        name: `Teacher ${i}`,
                        email: `teacher${i}@example.com`,
                        username: `teacher${i}`,
                    });
                }

                await supertest(app)
                    .get("/api/v1/teachers")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body).toHaveProperty("meta");

                        expect(Array.isArray(res.body.data)).toBe(true);

                        res.body.data.forEach((teacher: User) => {
                            expect(teacher).toHaveProperty("id");
                            expect(teacher).toHaveProperty("name");
                            expect(teacher).toHaveProperty("email");
                            expect(teacher.roleId).toBe(teacherRole.id);
                        });

                        expect(res.body.meta).toMatchObject({
                            totalItems: expect.any(Number),
                            itemCount: expect.any(Number),
                            itemsPerPage: 10,
                            totalPages: expect.any(Number),
                            currentPage: expect.any(Number),
                        });
                    });
            });

            it("Bisa mengembalikan daftar guru berdasarkan filter tertentu dan search", async () => {
                await createTestUser("Teacher", {
                    name: "John Doe",
                    email: "john.doe@example.com",
                    username: "johndoe",
                });

                await supertest(app)
                    .get("/api/v1/teachers")
                    .query({ search: "John" })
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        if (!Array.isArray(res.body.data)) throw new Error("'data' is not an array");
                        res.body.data.forEach((teacher: any) => {
                            expect(teacher.name).toContain("John");
                            expect(teacher.roleId).toBe(teacherRole.id);
                        });
                    });
            });

            it("Tidak boleh mengembalikan daftar guru jika page number < 1", async () => {
                await supertest(app)
                    .get("/api/v1/teachers?page=0")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.message).toBe("Invalid page number");
                    });
            });
        });

        describe("POST /api/v1/teachers", () => {
            it("Harus dapat menambahkan guru dengan input nama, email, dan username", async () => {
                const newTeacher = {
                    name: "New Teacher",
                    email: "new.teacher@example.com",
                    username: "newteacher",
                    password: "password",
                    profileImage: "http://example.com/profile.jpg",
                };

                await supertest(app)
                    .post("/api/v1/teachers")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send(newTeacher)
                    .expect(201)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body.data).toMatchObject({
                            name: newTeacher.name,
                            email: newTeacher.email,
                            username: newTeacher.username,
                            roleId: teacherRole.id,
                        });
                    });
            });

            it("Tidak boleh menambahkan guru dengan email yang sudah digunakan", async () => {
                await createTestUser("Teacher", {
                    email: "existing.teacher@example.com",
                });

                await supertest(app)
                    .post("/api/v1/teachers")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send({
                        name: "New Teacher",
                        email: "existing.teacher@example.com",
                        username: "newteacher",
                    })
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("email");
                    });
            });

            it("Tidak boleh menambahkan guru dengan username yang sudah digunakan", async () => {
                await createTestUser("Teacher", {
                    username: "existingteacher",
                });

                await supertest(app)
                    .post("/api/v1/teachers")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send({
                        name: "New Teacher",
                        email: "new.teacher@example.com",
                        username: "existingteacher",
                    })
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        res.body.error.forEach((err: string) => {
                            expect(err).toContain("username");
                        });
                    });
            });

            it("Tidak boleh menambahkan guru jika field nama, email, atau username kosong", async () => {
                await supertest(app)
                    .post("/api/v1/teachers")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send({
                        name: "",
                        email: "new.teacher@example.com",
                        username: "newteacher",
                    })
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        res.body.error.forEach((err: string) => {
                            expect(err).toContain("name");
                        });
                    });
            });
        });

        describe("GET /api/v1/teachers/:id", () => {
            it("Harus mengembalikan detail guru berupa nama, username, email, dan profile berdasarkan ID", async () => {
                const teacher = await createTestUser("Teacher", {
                    name: "John Doe",
                    email: "john.doe@example.com",
                    username: "johndoe",
                    profileImage: "Teacher profile",
                });

                await supertest(app)
                    .get(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        console.log(res.body)
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body.data).toMatchObject({
                            id: teacher.id,
                            name: teacher.name,
                            email: teacher.email,
                            username: teacher.username,
                            profileImage: teacher.profileImage,
                            roleId: teacherRole.id,
                        });
                    });
            });

            it("Tidak boleh mengembalikan detail guru jika ID tidak ditemukan", async () => {
                await supertest(app)
                    .get("/api/v1/teachers/nonexistent-id")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(404)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("not found");
                    });
            });
        });

        describe("PATCH /api/v1/teachers/:id", () => {
            it("Harus dapat mengupdate data guru berupa nama, email, dan username berdasarkan ID", async () => {
                const teacher = await createTestUser("Teacher");
                const updatedData = {
                    name: "Updated Teacher",
                    email: "updated.teacher@example.com",
                    username: "updatedteacher",
                };

                await supertest(app)
                    .patch(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send(updatedData)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body.data).toMatchObject({
                            id: teacher.id,
                            ...updatedData,
                            roleId: teacherRole.id,
                        });
                    });
            });

            it("Tidak boleh mengupdate guru dengan email invalid format", async () => {
                const teacher = await createTestUser("Teacher");

                await supertest(app)
                    .patch(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send({
                        email: "invalid-email",
                    })
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("email");
                    });
            });

            it("Tidak boleh mengupdate guru jika ID tidak ditemukan", async () => {
                await supertest(app)
                    .patch("/api/v1/teachers/nonexistent-id")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .send({
                        name: "Updated Teacher",
                    })
                    .expect(404)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("not found");
                    });
            });
        });

        describe("DELETE /api/v1/teachers/:id", () => {
            it("Harus dapat menghapus data guru berdasarkan ID", async () => {
                const teacher = await createTestUser("Teacher");

                await supertest(app)
                    .delete(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                    });

                const deletedTeacher = await prisma.user.findUnique({ where: { id: teacher.id } });
                expect(deletedTeacher).toBeNull();
            });

            it("Tidak boleh menghapus guru jika ID tidak ditemukan", async () => {
                await supertest(app)
                    .delete("/api/v1/teachers/nonexistent-id")
                    .set("Authorization", `Bearer ${adminToken}`)
                    .expect(404)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("not found");
                    });
            });
        });
    });

    describe("Role: Guru", () => {
        let teacherToken: string;
        let teacher: User;
        let teacherRole: any;

        beforeEach(async () => {
            await prisma.user.deleteMany({});
            teacherRole = await prisma.role.findFirst({ where: { name: "Teacher" } });
            teacher = await createTestUser("Teacher", {
                name: "Teacher User",
                email: "teacher.user@example.com",
                username: "teacheruser",
            });
            teacherToken = await generateToken("Teacher", teacher.id);
        });

        describe("GET /api/v1/teachers/:id", () => {
            it("Harus mengembalikan detail guru berupa nama, username, email, dan profile berdasarkan ID", async () => {
                await supertest(app)
                    .get(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${teacherToken}`)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body.data).toMatchObject({
                            id: teacher.id,
                            name: teacher.name,
                            email: teacher.email,
                            username: teacher.username,
                            roleId: teacherRole.id,
                        });
                    });
            });
            // TODO: Uncomment when implementing login and role validation
            // it("Tidak boleh mengakses detail guru lain berdasarkan ID", async () => {
            //     const otherTeacher = await createTestUser("Teacher", {
            //         name: "Other Teacher",
            //         email: "other.teacher@example.com",
            //         username: "otherteacher",
            //     });

            //     await supertest(app)
            //         .get(`/api/v1/teachers/${otherTeacher.id}`)
            //         .set("Authorization", `Bearer ${teacherToken}`)
            //         .expect(403)
            //         .expect("Content-Type", /json/)
            //         .expect((res) => {
            //             expect(res.body.success).toBe(false);
            //             expect(res.body.message).toContain("forbidden");
            //         });
            // });

            // it("Tidak boleh mengupdate guru lain berdasarkan ID", async () => {
            //     const otherTeacher = await createTestUser("Teacher", {
            //         name: "Other Teacher",
            //         email: "other.teacher@example.com",
            //         username: "otherteacher",
            //     });

            //     await supertest(app)
            //         .patch(`/api/v1/teachers/${otherTeacher.id}`)
            //         .set("Authorization", `Bearer ${teacherToken}`)
            //         .send({
            //             name: "Updated Name",
            //         })
            //         .expect(403)
            //         .expect("Content-Type", /json/)
            //         .expect((res) => {
            //             expect(res.body.success).toBe(false);
            //             expect(res.body.message).toContain("forbidden");
            //         });
            // });
        });

        describe("PATCH /api/v1/teachers/:id", () => {
            it("Harus dapat mengupdate data guru berupa nama, email, dan username berdasarkan ID", async () => {
                const updatedData = {
                    name: "Updated Teacher",
                    email: "updated.teacher@example.com",
                    username: "updatedteacher",
                };

                await supertest(app)
                    .patch(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${teacherToken}`)
                    .send(updatedData)
                    .expect(200)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body).toHaveProperty("success", true);
                        expect(res.body).toHaveProperty("message");
                        expect(res.body).toHaveProperty("data");
                        expect(res.body.data).toMatchObject({
                            id: teacher.id,
                            ...updatedData,
                            roleId: teacherRole.id,
                        });
                    });
            });

            it("Tidak boleh mengupdate data guru dengan email invalid format", async () => {
                await supertest(app)
                    .patch(`/api/v1/teachers/${teacher.id}`)
                    .set("Authorization", `Bearer ${teacherToken}`)
                    .send({
                        email: "invalid-email",
                    })
                    .expect(400)
                    .expect("Content-Type", /json/)
                    .expect((res) => {
                        expect(res.body.success).toBe(false);
                        expect(res.body.message).toContain("email");
                    });
            });
        });
    });
    // TODO: Uncomment when implementing authentication
    // describe("Authorization & Authentication", () => {
    //     let adminToken: string;
    //     let teacherToken: string;
    //     let teacher: User;

    //     beforeEach(async () => {
    //         await prisma.user.deleteMany({});
    //         adminToken = await generateToken("Admin");
    //         teacher = await createTestUser("Teacher");
    //         teacherToken = await generateToken("Teacher", teacher.id);
    //     });

    //     it("Tidak boleh mengakses endpoint guru tanpa token", async () => {
    //         await supertest(app)
    //             .get("/api/v1/teachers")
    //             .expect(401)
    //             .expect("Content-Type", /json/)
    //             .expect((res) => {
    //                 expect(res.body.success).toBe(false);
    //                 expect(res.body.message).toContain("token");
    //             });
    //     });

    //     it("Tidak boleh mengakses endpoint guru dengan token invalid", async () => {
    //         await supertest(app)
    //             .get("/api/v1/teachers")
    //             .set("Authorization", "Bearer invalid-token")
    //             .expect(401)
    //             .expect("Content-Type", /json/)
    //             .expect((res) => {
    //                 expect(res.body.success).toBe(false);
    //                 expect(res.body.message).toContain("token");
    //             });
    //     });

    //     it("Tidak boleh mengakses endpoint role Admin jika login sebagai Guru", async () => {
    //         await supertest(app)
    //             .post("/api/v1/teachers")
    //             .set("Authorization", `Bearer ${teacherToken}`)
    //             .send({
    //                 name: "New Teacher",
    //                 email: "new.teacher@example.com",
    //                 username: "newteacher",
    //             })
    //             .expect(403)
    //             .expect("Content-Type", /json/)
    //             .expect((res) => {
    //                 expect(res.body.success).toBe(false);
    //                 expect(res.body.message).toContain("forbidden");
    //             });
    //     });
    // });
});