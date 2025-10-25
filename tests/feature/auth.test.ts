import prisma from '../../src/database';
import { randPastDate, randUserName } from '@ngneat/falso';
import bcrypt from 'bcrypt';
import { User } from '@prisma/client';
import superjest from 'supertest';
import app from "../../src";

describe('Feature Auth', () => {
    const baseUrl = '/api/v1';
    let user: User;
    let password: string;
    let token: string;

    beforeAll(async () => {

        const studentRole = await prisma.role.findUnique({ where: { name: "Student" } });
        if (!studentRole) {
            throw new Error("Roles not found");
        }
        password = 'test user';
        const hashedPassword = await bcrypt.hash(password, 10);

        const existingUser = await prisma.user.findUnique({ where: { email: 'testuser@example.com' } });
        if (existingUser) {
            user = existingUser;
            return;
        }

        user = await prisma.user.create({
            data: {
                username: `test user`,
                email: `testuser@example.com`,
                name: randUserName(),
                roleId: studentRole.id,
                profileImage: `https://ui-avatars.com/api/?name=Test+User&background=random`,
                password: hashedPassword,
                createdAt: randPastDate({ years: 5 }),
            }
        });

        console.log("Test user created:", user.username);

    });

    afterAll(async () => {
        await prisma.reset_Token.deleteMany({
            where: {
                userId: user.id
            }
        });

        await prisma.oTP_Token.deleteMany({
            where: {
                userId: user.id
            }
        });

        await prisma.user.delete({
            where: {
                email: 'testuser@example.com'
            }
        });
    });

    describe('POST /api/v1/login', () => {
        it('should login successfully with valid credentials', async () => {
            const res = await superjest(app)
                .post(`${baseUrl}/login`)
                .send({ username: user.username, password: password });
            console.log("Login response:", res.body);
            expect(res.status).toBe(200);
            expect(res.body.data["token"]).toBeDefined();
            token = res.body.data["token"];
        });

        it('should fail login with invalid credentials', async () => {

            const res = await superjest(app)
                .post(`${baseUrl}/login`)
                .send({ username: user.username, password: "wrong password" });
            expect(res.status).toBe(401);
            expect(res.body.message).toContain('Invalid credentials');
        });

        it('should return required update after login if username and password is the same', async () => {
            const res = await superjest(app)
                .post(`${baseUrl}/login`)
                .send({ username: user.username, password: password });
            expect(res.status).toBe(200);
            expect(res.body.data["token"]).toBeDefined();
            console.log("Login response:", res.body);
            expect(res.body.data["isSameCredentials"]).toBe(true);
        });
    })

    describe('POST /api/v1/forgot-password', () => {
        it('should send reset password email', async () => {
            const res = await superjest(app)
                .post(`${baseUrl}/forgot-password`)
                .send({ email: `testuser@example.com` });

            console.log("Forgot password response:", res.body);
            expect(res.status).toBe(200);
        });
    })

    describe('POST /api/v1/verify-otp', () => {
        it('should verify OTP and return reset token', async () => {
            const otpRecord = await prisma.oTP_Token.findFirst({
                where: { userId: user.id },
                orderBy: { createdAt: 'desc' },
            });

            if (!otpRecord) {
                throw new Error("OTP record not found for testing");
            }

            const res = await superjest(app)
                .post(`${baseUrl}/verify-otp`)
                .send({
                    email: user.email,
                    code: otpRecord.code,
                });
            console.log("Verify OTP response:", res.body);
            expect(res.status).toBe(200);
            expect(res.body.data["token"]).toBeDefined();
        });
    });

    describe('POST /api/v1/reset-password', () => {
        it('should reset password successfully', async () => {
            const token = await prisma.reset_Token.findFirst({
                where: {
                    userId: user.id,
                },
                orderBy: { createdAt: 'desc' },
            });
            if (!token) {
                throw new Error("Reset token not found for testing");
            }
            const res = await superjest(app)
                .patch(`${baseUrl}/reset-password`)
                .send({
                    reset_token: token.token,
                    newPassword: 'NewPass123',
                    confirmPassword: 'NewPass123',
                });
            expect(res.status).toBe(200);
        });
    })


    describe('POST /api/v1/register', () => {
        it('should register a new user successfully', async () => {
            const user = await prisma.user.findUnique({
                where: { email: 'newuser@example.com' }
            });
            if (user) {
                await prisma.oTP_Token.deleteMany({
                    where: {
                        userId: user.id
                    }
                });

                await prisma.user.delete({
                    where: { email: 'newuser@example.com' }
                });
            }

            const res = await superjest(app)
                .post(`${baseUrl}/register`)
                .send({
                    username: 'newuser',
                    email: 'newuser@example.com',
                    name: 'New User',
                    password: 'NewUserPass123',
                    passwordConfirmation: 'NewUserPass123',
                });

            console.log("Register response:", res.body);
            expect(res.status).toBe(201);
            expect(res.body.data).toBeDefined();
        });
    });


});

