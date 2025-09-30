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

describe("Manajemen Kelas (Guru)", () => {
    let createdId: number;

    afterAll(async () => {
        await prisma.class.deleteMany(); // cleanup DB
        await prisma.$disconnect();
    });

    describe("1. Create Class", () => {
        it("should create a new class with valid data", async () => {
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

        it("should fail if required fields are missing", async () => {
            const res = await request(app)
                .post("/api/v1/classes")
                .send({})
                .expect(400);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.errors?.validation).toBeDefined();
        });
    });

    describe("2. Get Classes", () => {
        it("should return paginated list of classes", async () => {
            const res = await request(app).get("/api/v1/classes?page=1&limit=10").expect(200);

            const body: BaseResponse<ClassDto[]> = res.body;

            expect(body.success).toBe(true);
            expect(Array.isArray(body.data)).toBe(true);
            expect(body.meta).toBeDefined();
            expect(body.meta?.totalItems).toBeGreaterThanOrEqual(1);
        });

        it("should return class detail by id", async () => {
            const res = await request(app).get(`/api/v1/classes/${createdId}`).expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.id).toBe(createdId);
            expect(body.data.name).toBe("Kelas A");
        });
    });

    describe("3. Update Class", () => {
        it("should update only provided fields", async () => {
            const res = await request(app)
                .patch(`/api/v1/classes/${createdId}`)
                .send({ description: "Deskripsi kelas terbaru" })
                .expect(200);

            const body: BaseResponse<ClassDto> = res.body;

            expect(body.success).toBe(true);
            expect(body.data.description).toBe("Deskripsi kelas terbaru");
        });

        it("should return 404 if class not found", async () => {
            const res = await request(app)
                .patch("/api/v1/classes/99999")
                .send({ description: "Update gagal" })
                .expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
        });
    });

    describe("4. Delete Class", () => {
        it("should delete class if exists", async () => {
            const res = await request(app).delete(`/api/v1/classes/${createdId}`).expect(200);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(true);
            expect(body.message).toMatch(/deleted/i);
        });

        it("should return 404 if class not found", async () => {
            const res = await request(app).delete(`/api/v1/classes/${createdId}`).expect(404);

            const body: BaseResponse<null> = res.body;

            expect(body.success).toBe(false);
            expect(body.message).toMatch(/not found/i);
        });
    });
});
