import request from "supertest";
import app from "../../src";
import { PrismaClient } from "@prisma/client";
import { BaseResponse } from "../../src/api/v1/types/responseType";
const prisma = new PrismaClient();

interface ClassDto {
    id: number;
    name: string;
    description: string;
    createdAt: string;
    updatedAt: string;
}

describe("Feature Kelas", () => {
    let createdId: number;

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
            expect(body.meta?.totalItems).toBeGreaterThanOrEqual(1);
        });
    });

    describe("GET /api/v1/classes/:id", () => {
        it("Harus dapat mengembalikan detail kelas dengan menggunakan id", async () => {
            const res = await request(app).get(`/api/v1/classes/${createdId}`).expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.id).toBe(createdId);
            expect(body.data.name).toBe("Kelas A");
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

            createdId = body.data.id;
        });

        it("Tidak bisa membuat kelas jika data tidak lengkap", async () => {
            const res = await request(app)
                .post("/api/v1/classes")
                .send({})
                .expect(400);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.errors?.validation).toBeDefined();
        });
    });


    describe("PATCH /api/v1/classes/:id", () => {
        it("Harus dapat update data kelas dengan menggunakan data yang valid", async () => {
            const res = await request(app)
                .patch(`/api/v1/classes/${createdId}`)
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
            const res = await request(app).delete(`/api/v1/classes/${createdId}`).expect(200);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/deleted/i);
        });

        it("Mengembalikan 404 bila kelas tidak ditemukan", async () => {
            const res = await request(app).delete(`/api/v1/classes/${createdId}`).expect(404);
            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
        });
    });
});
