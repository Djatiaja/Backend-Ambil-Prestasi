import prisma from '../src/database';
import request from 'supertest';
import app from '../src';

jest.mock('../src/database', () => {
    return {
        __esModule: true,
        default: {
            user: {
                findMany: jest.fn(),
                findUnique: jest.fn(),
                create: jest.fn(),
                update: jest.fn(),
                delete: jest.fn(),
            }
        }
    };
});


describe('Teachers API', () => {
    const mockedPrisma = prisma as any;
    const consoleLogSpy = jest.spyOn(console, 'log').mockImplementation(() => { });

    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('GET /teachers (list) with pagination, search, sort', () => {
        it('should return 10 teachers (default limit) with meta', async () => {
            const sample = Array.from({ length: 10 }).map((_, i) => ({ id: `id-${i}`, name: `Teacher ${i}`, email: `t${i}@x.com` }));
            mockedPrisma.user.findMany.mockResolvedValue(sample);

            const res = await request(app).get('/teachers').expect(200);
            expect(res.body.data).toHaveLength(10);
            expect(res.body.meta).toMatchObject({ page: 1, limit: 10 });
            expect(mockedPrisma.user.findMany).toHaveBeenCalled();
        });

        it('should accept page, limit, search and sort=name_asc', async () => {
            const sample = [{ id: '1', name: 'A Teacher', email: 'a@x.com' }];
            mockedPrisma.user.findMany.mockResolvedValue(sample);

            const res = await request(app).get('/teachers').query({ page: 2, limit: 5, search: 'A', sort: 'name_asc' }).expect(200);
            expect(res.body.meta).toMatchObject({ page: 2, limit: 5 });
            expect(res.body.data[0].name).toBe('A Teacher');
            expect(mockedPrisma.user.findMany).toHaveBeenCalledWith(expect.objectContaining({
                take: 5,
                skip: 5,
                orderBy: { name: 'asc' }
            }));
        });

        it('should return 400 on invalid query params', async () => {
            await request(app).get('/teachers').query({ page: 0 }).expect(400);
        });
    });

    describe('GET /teachers/:id (detail)', () => {
        it('should return teacher detail when found', async () => {
            mockedPrisma.user.findUnique.mockResolvedValue({ id: 't1', name: 'T1', email: 't1@x.com', username: 't1', profileImage: 'p.png' });
            const res = await request(app).get('/teachers/t1').expect(200);
            expect(res.body.data.id).toBe('t1');
            expect(mockedPrisma.user.findUnique).toHaveBeenCalledWith(expect.objectContaining({ where: { id: 't1' } }));
        });

        it('should return 404 when not found', async () => {
            mockedPrisma.user.findUnique.mockResolvedValue(null);
            await request(app).get('/teachers/nonexistent').expect(404);
        });
    });

    describe('POST /teachers (create)', () => {
        it('should validate input and return 400 for invalid body', async () => {
            await request(app).post('/teachers').send({ name: '', email: 'not-email' }).expect(400);
        });

        it('should create teacher and log activity', async () => {
            const newUser = { id: 'new-1', name: 'New Teacher', email: 'new@x.com', username: 'newuser' };
            mockedPrisma.user.create.mockResolvedValue(newUser);

            const res = await request(app).post('/teachers').send({ name: 'New Teacher', email: 'new@x.com', username: 'newuser' }).expect(201);
            expect(res.body.message).toContain('berhasil');
            expect(res.body.data.id).toBe('new-1');
            expect(consoleLogSpy).toHaveBeenCalledWith(expect.stringContaining('[ACTIVITY] create_teacher'), expect.any(Object));
        });

        it('should return 400 when prisma reports unique constraint (P2002)', async () => {
            const err: any = new Error('Unique');
            err.code = 'P2002';
            err.meta = { target: ['email'] };
            mockedPrisma.user.create.mockRejectedValue(err);

            const res = await request(app).post('/teachers').send({ name: 'X', email: 'x@x.com', username: 'u' }).expect(400);
            expect(res.body.error).toMatch(/sudah/);
        });
    });

    describe('PUT /teachers/:id (edit)', () => {
        it('should validate and update teacher', async () => {
            const updated = { id: 't1', name: 'Updated', email: 'u@x.com', username: 'u1' };
            mockedPrisma.user.update.mockResolvedValue(updated);

            const res = await request(app).put('/teachers/t1').send({ name: 'Updated' }).expect(200);
            expect(res.body.data.name).toBe('Updated');
            expect(consoleLogSpy).toHaveBeenCalledWith(expect.stringContaining('[ACTIVITY] update_teacher'), expect.any(Object));
        });

        it('should return 404 when prisma returns P2025 (not found)', async () => {
            const err: any = new Error('NotFound'); err.code = 'P2025';
            mockedPrisma.user.update.mockRejectedValue(err);
            await request(app).put('/teachers/missing').send({ name: 'X' }).expect(404);
        });

        it('should return 400 when unique constraint violation during update', async () => {
            const err: any = new Error('Unique'); err.code = 'P2002';
            mockedPrisma.user.update.mockRejectedValue(err);
            const res = await request(app).put('/teachers/t1').send({ email: 'exists@x.com' }).expect(400);
            expect(res.body.error).toMatch(/sudah/);
        });
    });

    describe('DELETE /teachers/:id (delete) requires confirm', () => {
        it('should require confirm query param', async () => {
            await request(app).delete('/teachers/t1').expect(400);
        });

        it('should delete when confirm=true and log', async () => {
            mockedPrisma.user.delete.mockResolvedValue({ id: 't1', name: 'T1', email: 't1@x.com' });
            const res = await request(app).delete('/teachers/t1').query({ confirm: 'true' }).expect(200);
            expect(res.body.message).toMatch(/berhasil dihapus/);
            expect(consoleLogSpy).toHaveBeenCalledWith(expect.stringContaining('[ACTIVITY] delete_teacher'), expect.any(Object));
        });

        it('should return 404 when prisma P2025', async () => {
            const err: any = new Error('NotFound'); err.code = 'P2025';
            mockedPrisma.user.delete.mockRejectedValue(err);
            await request(app).delete('/teachers/t1').query({ confirm: 'true' }).expect(404);
        });
    });

    describe('GET /teachers/search (by name/email) - return null if empty', () => {
        it('should return null when no results', async () => {
            mockedPrisma.user.findMany.mockResolvedValue([]);
            const res = await request(app).get('/teachers/search').query({ name: 'nobody' }).expect(200);
            expect(res.body.data).toBeNull();
        });

        it('should return results when present', async () => {
            mockedPrisma.user.findMany.mockResolvedValue([{ id: '1', name: 'Found', email: 'f@x.com' }]);
            const res = await request(app).get('/teachers/search').query({ email: 'f@x.com' }).expect(200);
            expect(res.body.data).toHaveLength(1);
        });

        it('should return 400 when neither name nor email provided', async () => {
            await request(app).get('/teachers/search').expect(400);
        });
    });
});
