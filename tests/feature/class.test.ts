import superjest from "supertest";
import app from "../../src";
import { BaseResponse } from "../../src/api/v1/types/responseType";
import classRepository from "../../src/api/v1/repositories/class.repository";
import * as classController from "../../src/api/v1/controllers/class.controller";
import prisma from "../../src/database";
import { hash } from "crypto";
import { randPastDate } from "@ngneat/falso";

interface ClassDto {
    id: number;
    name: string;
    description: string;
    createdAt: string;
    updatedAt: string;
}

// Mock the classRepository
jest.mock("../../src/api/v1/repositories/class.repository");

describe("Feature Kelas", () => {

    // beforeAll(async () => {
    //     const teacherRole = await prisma.role.findUnique({ where: { name: "Teacher" } });
    //     const hashedPassword = hash("sha256", "password123");
    //     const testUser = await prisma.user.findFirst({
    //         where: {
    //             email: `test-${Date.now()}@example.com`,
    //         }
    //     });

    //     if (!testUser) {
    //         return testUser
    //     }
    //     await prisma.user.create({
    //         data: {
    //             username: `teachertestacc`,
    //             email: `teachertestaccexample.com`,
    //             name: 'teachertestacc',
    //             roleId: teacherRole!.id,
    //             profileImage: `https://ui-avatars.com/api/?name=teachertestacc&background=random`,
    //             password: hashedPassword,
    //             createdAt: randPastDate({ years: 5 }),
    //         }
    //     })
    // })

    beforeEach(() => {
        jest.clearAllMocks(); // Clear mocks before each test to ensure isolation
    });

    describe("GET /api/v1/classes", () => {
        it("Harus dapat mengembalikan list kelas dengan menggunakan pagination", async () => {
            // Mocked password hash for test user
            const hashedPassword = "testhashedpassword";
            // Mocked function to return a past date
            const randPastDate = ({ years }: { years: number }) => {
                const date = new Date();
                date.setFullYear(date.getFullYear() - years);
                return date;
            };

            const mockClasses = [
                {
                    id: 1,
                    name: "Kelas A",
                    description: "Deskripsi kelas A",
                    image_path: "",
                    createdAt: new Date("2025-10-01T00:00:00Z"),
                    updatedAt: new Date("2025-10-01T00:00:00Z"),
                },
                {
                    id: 2,
                    name: "Kelas B",
                    description: "Deskripsi kelas B",
                    image_path: "",
                    createdAt: new Date("2025-10-01T00:00:00Z"),
                    updatedAt: new Date("2025-10-01T00:00:00Z"),
                },
            ];

            (classRepository.getClasses as jest.Mock).mockResolvedValue(mockClasses);
            (classRepository.getCount as jest.Mock).mockResolvedValue(2);

            jest.spyOn(classController, "getTestTeacher").mockResolvedValue({
                id: "asdfasd",
                username: "admin",
                email: "djamgt23@gmail.com",
                name: "Admin User",
                roleId: 1,
                profileImage: "https://ui-avatars.com/api/?name=Admin+User&background=random",
                password: hashedPassword,
                createdAt: randPastDate({ years: 1 }),
                updatedAt: randPastDate({ years: 1 }),
                verified_at: null
            });

            const res = await superjest(app).get("/api/v1/classes?page=1&limit=10");

            const body: BaseResponse<ClassDto[]> = res.body;

            expect(body.success).toBe(true);
            expect(Array.isArray(body.data)).toBe(true);
            expect(body.data).toHaveLength(2);
            expect(body.data[0]).toMatchObject({
                id: 1,
                name: "Kelas A",
                description: "Deskripsi kelas A",
            });
            expect(body.meta).toEqual({
                totalItems: 2,
                currentPage: 1,
                itemsPerPage: 10,
                totalPages: 1
            });
            expect(classRepository.getClasses).toHaveBeenCalledWith(expect.any(String), 0, 10);
            expect(classRepository.getCount).toHaveBeenCalled();
        });
    });

    describe("GET /api/v1/classes/:id", () => {
        it("Harus dapat mengembalikan detail kelas dengan menggunakan id", async () => {
            const mockClass = {
                id: 1,
                name: "test",
                description: "test",
                image_path: "test",
                createdAt: new Date("2025-10-01T00:00:00Z"),
                updatedAt: new Date("2025-10-01T00:00:00Z"),
            };

            (classRepository.findClassById as jest.Mock).mockResolvedValue(mockClass);

            const res = await superjest(app).get(`/api/v1/classes/${mockClass.id}`).expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data).toMatchObject({
                id: mockClass.id,
                name: "test",
                description: "test",
            });
            expect(classRepository.findClassById).toHaveBeenCalledWith(mockClass.id);
        });

        it("Mengembalikan 404 jika kelas tidak ditemukan", async () => {
            (classRepository.findClassById as jest.Mock).mockResolvedValue(null);

            const res = await superjest(app).get("/api/v1/classes/999999999999").expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
            expect(classRepository.findClassById).toHaveBeenCalledWith(999999999999);
        });
    });

    describe("POST /api/v1/classes", () => {
        it("Harus dapat membuat kelas baru dengan data valid", async () => {

            // Mocked password hash for test user
            const hashedPassword = "testhashedpassword";
            // Mocked function to return a past date
            const randPastDate = ({ years }: { years: number }) => {
                const date = new Date();
                date.setFullYear(date.getFullYear() - years);
                return date;
            };

            const mockClass = {
                id: 1,
                name: "Kelas A",
                description: "Deskripsi kelas A",
                image_path: "/image.png",
                createdAt: new Date("2025-10-01T00:00:00Z"),
                updatedAt: new Date("2025-10-01T00:00:00Z"),
            };

            (classRepository.createClass as jest.Mock).mockResolvedValue(mockClass);

            jest.spyOn(classController, "getTestTeacher").mockResolvedValue({
                id: "asdfasd",
                username: "admin",
                email: "djamgt23@gmail.com",
                name: "Admin User",
                roleId: 1,
                profileImage: "https://ui-avatars.com/api/?name=Admin+User&background=random",
                password: hashedPassword,
                createdAt: randPastDate({ years: 1 }),
                updatedAt: randPastDate({ years: 1 }),
                verified_at: null
            });

            const res = await superjest(app)
                .post("/api/v1/classes")
                .send({
                    name: "Kelas A",
                    description: "Deskripsi kelas A",
                })
                .expect(201);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/created/i);
            expect(body.data).toMatchObject({
                id: mockClass.id,
                name: "Kelas A",
                description: "Deskripsi kelas A",
            });
        });

        it("Tidak bisa membuat kelas jika data tidak lengkap", async () => {
            const res = await superjest(app)
                .post("/api/v1/classes")
                .send({ name: "Kelas A" })
                .expect(400);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.errors?.validation).toBeDefined();
            expect(classRepository.createClass).not.toHaveBeenCalled();
        });
    });

    describe("PATCH /api/v1/classes/:id", () => {
        it("Harus dapat update data kelas dengan menggunakan data yang valid", async () => {
            const mockClass = {
                id: 1,
                name: "test",
                description: "test",
                image_path: "test",
                createdAt: new Date("2025-10-01T00:00:00Z"),
                updatedAt: new Date("2025-10-01T00:00:00Z"),
            };

            const updatedClass = {
                ...mockClass,
                description: "Deskripsi kelas terbaru",
                updatedAt: new Date("2025-10-02T00:00:00Z"),
            };

            (classRepository.findClassById as jest.Mock).mockResolvedValue(mockClass);
            (classRepository.updateClass as jest.Mock).mockResolvedValue(updatedClass);

            const res = await superjest(app)
                .patch(`/api/v1/classes/${mockClass.id}`)
                .send({ description: "Deskripsi kelas terbaru" })
                .expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.description).toBe("Deskripsi kelas terbaru");
            expect(classRepository.findClassById).toHaveBeenCalledWith(mockClass.id);
            expect(classRepository.updateClass).toHaveBeenCalledWith(mockClass.id, {
                name: mockClass.name,
                description: "Deskripsi kelas terbaru",
            });
        });

        it("Tidak boleh mengupdate jika kelas tidak tersedia", async () => {
            (classRepository.findClassById as jest.Mock).mockResolvedValue(null);

            const res = await superjest(app)
                .patch("/api/v1/classes/99999")
                .send({ description: "Update gagal" })
                .expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
            expect(classRepository.findClassById).toHaveBeenCalledWith(99999);
            expect(classRepository.updateClass).not.toHaveBeenCalled();
        });
    });

    describe("DELETE /api/v1/classes/:id", () => {
        it("Harus dapat menghapus kelas jika kelas tersedia", async () => {
            const mockClass = {
                id: 1,
                name: "test",
                description: "test",
                image_path: "test",
                createdAt: new Date("2025-10-01T00:00:00Z"),
                updatedAt: new Date("2025-10-01T00:00:00Z"),
            };

            (classRepository.findClassById as jest.Mock).mockResolvedValue(mockClass);
            (classRepository.deleteClass as jest.Mock).mockResolvedValue(undefined);

            const res = await superjest(app).delete(`/api/v1/classes/${mockClass.id}`).expect(200);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/deleted/i);
            expect(classRepository.findClassById).toHaveBeenCalledWith(mockClass.id);
            expect(classRepository.deleteClass).toHaveBeenCalledWith(mockClass.id);
        });

        it("Mengembalikan 404 bila kelas tidak ditemukan", async () => {
            (classRepository.findClassById as jest.Mock).mockResolvedValue(null);

            const res = await superjest(app).delete("/api/v1/classes/99999999").expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
            expect(classRepository.findClassById).toHaveBeenCalledWith(99999999);
            expect(classRepository.deleteClass).not.toHaveBeenCalled();
        });
    });
});
