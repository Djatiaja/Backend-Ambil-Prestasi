import request from "supertest";
import app from "../../src";
import { BaseResponse } from "../../src/api/v1/types/responseType";
import prisma from "../../src/database";
import { classesSeed } from "../../src/database/seeders/classes.seed";
import classRepository from "../../src/api/v1/repositories/class.repository";

interface ClassDto {
    id: number;
    name: string;
    description: string;
    createdAt: string;
    updatedAt: string;
}

describe("Feature Kelas", () => {

    beforeAll(async () => {
        await classesSeed();
    })

    afterAll(async () => {
        await prisma.class.deleteMany(); // cleanup DB
        await prisma.$disconnect();
    });


    describe("GET /api/v1/classes", () => {
        it("Harus dapat mengembalikan list kelas dengan menggunakan pagination", async () => {
            const res = await request(app).get("/api/v1/classes?page=1&limit=10").expect(200);

            const body: BaseResponse<ClassDto[]> = res.body;

            expect(body.success).toBe(true);
            expect(Array.isArray(body.data)).toBe(true);
            expect(body.meta).toBeDefined();
            expect(body.meta?.totalItems).toBeGreaterThanOrEqual(0);
        });
    });

    describe("GET /api/v1/classes/:id", () => {
        it("Harus dapat mengembalikan detail kelas dengan menggunakan id", async () => {
            const testClass = await classRepository.createClass(
                "test",
                "test desc"
            )


            const res = await request(app).get(`/api/v1/classes/${testClass.id}`).expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.id).toBe(testClass.id);
            expect(body.data.name).toBe("Kelas A");
        });

        it("Mengembalikan 404 jika kelas tidak ditemukan", async () => {
            await request(app).get(`/api/v1/classes/999999999999`).expect(404);
        });

    })


    describe("POST /api/v1/classes", () => {
        it("Harus dapat membuat kelas baru dengan data valid", async () => {
            const res = await request(app)
                .post("/api/v1/classes")
                .send({
                    name: "Kelas A",
                    description: "Deskripsi kelas A"
                })
                .expect(201);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/created/i);
            expect(body.data.id).toBeDefined();
            expect(body.data.name).toBe("Kelas A");
        });

        it("Tidak bisa membuat kelas jika data tidak lengkap", async () => {
            const res = await request(app)
                .post("/api/v1/classes")
                .send({ name: "Kelas A" })
                .expect(400);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.errors?.validation).toBeDefined();
        });
    });


    describe("PATCH /api/v1/classes/:id", () => {
        it("Harus dapat update data kelas dengan menggunakan data yang valid", async () => {
            const testClass = await classRepository.createClass(
                "test",
                "test desc"
            )
            const res = await request(app)
                .patch(`/api/v1/classes/${testClass.id}`)
                .send({ description: "Deskripsi kelas terbaru" })
                .expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.description).toBe("Deskripsi kelas terbaru");
        });

        it("Tidak boleh mengupdate jika kelas tidak tersedia", async () => {
            const res = await request(app)
                .patch("/api/v1/classes/99999")
                .send({ description: "Update gagal" })
                .expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
        });
    });

    describe("DELETE /api/v1/classes/:id", () => {
        it("Harus dapat menghapus kelas jika kelas tersedia", async () => {
            const testClass = await classRepository.createClass(
                "test",
                "test desc"
            )

            const res = await request(app).delete(`/api/v1/classes/${testClass.id}`).expect(200);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/deleted/i);
        });

        it("Mengembalikan 404 bila kelas tidak ditemukan", async () => {
            const res = await request(app).delete(`/api/v1/classes/99999999`).expect(404);
            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
        });
    });
});
