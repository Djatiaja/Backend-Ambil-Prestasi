import request from 'supertest';
import app from '../../src';

describe('Feature Auth', () => {
    const baseUrl = '/api/v1';
    let token: string;

    describe('POST /api/v1/login', () => {
        it('should login successfully with valid credentials', async () => {
            const res = await request(app)
                .post(`${baseUrl}/login`)
                .send({ username: 'root', password: 'supersecret' });
            expect(res.status).toBe(200);
            expect(res.body.data["token"]).toBeDefined();
            token = res.body.data["token"];
        });

        it('should fail login with invalid credentials', async () => {
            const res = await request(app)
                .post(`${baseUrl}/login`)
                .send({ username: 'root', password: 'wrongpass' });
            expect(res.status).toBe(401);
            expect(res.body.message).toContain('Invalid credentials');
        });

        it('should return required update after login if username and password is the same', async () => {
            const res = await request(app)
                .post(`${baseUrl}/login`)
                .send({ username: 'root', password: 'supersecret' });
            expect(res.status).toBe(401);
            expect(res.body.data["token"]).toBeDefined();
            expect(res.body.message).toContain('Invalid credentials');
        });
    })

    describe('POST /api/v1/forgot-password', () => {
        it('should send reset password email', async () => {
            const res = await request(app)
                .post(`${baseUrl}/forgot-password`)
                .send({ email: 'superadmin@example.com' });
            expect(res.status).toBe(200);
        });
    })

    describe('POST /api/v1/verify-token', () => {
        it('should verify valid reset token', async () => {
            const res = await request(app)
                .post(`${baseUrl}/verify-reset-token`)
                .send({ token: 'VALID_TOKEN' });
            expect(res.status).toBe(200);
        });

    })

    describe('POST /api/v1/reset-password', () => {
        it('should reset password successfully', async () => {
            const res = await request(app)
                .patch(`${baseUrl}/reset-password`)
                .send({
                    token: 'VALID_TOKEN',
                    newPassword: 'NewPass123',
                    confirmPassword: 'NewPass123',
                });
            expect(res.status).toBe(200);
        });
    })



})



