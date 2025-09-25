import request from 'supertest';
import app from '../../src';


describe('GET /dashboard', () => {
    it('should return dashboard data with teacher and student charts', async () => {
        const response = await request(app).get('/api/v1/dashboard');

        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty('success', true);
        expect(response.body).toHaveProperty('message', 'dashboard fetched successfully');
        expect(response.body).toHaveProperty('data');

        const data = response.body.data;

        // Check counts
        expect(data).toHaveProperty('teacherCount');
        expect(typeof data.teacherCount).toBe('number');

        expect(data).toHaveProperty('studentCount');
        expect(typeof data.studentCount).toBe('number');

        expect(data).toHaveProperty('classCount');
        expect(typeof data.classCount).toBe('number');

        // Check Chart structure
        expect(data).toHaveProperty('Chart');
        const chart = data.Chart;

        ['teacher', 'student'].forEach((role) => {
            expect(chart).toHaveProperty(role);
            expect(chart[role]).toHaveProperty('oneYear');
            expect(chart[role]).toHaveProperty('fiveYear');

            const oneYear = chart[role].oneYear;
            const fiveYear = chart[role].fiveYear;

            // One year: should have keys 1-12
            for (let month = 1; month <= 12; month++) {
                expect(oneYear).toHaveProperty(month.toString());
                expect(typeof oneYear[month]).toBe('number');
            }

            // Five year: should have 5 years as keys
            const currentYear = new Date().getFullYear();
            for (let y = currentYear - 4; y <= currentYear; y++) {
                expect(fiveYear).toHaveProperty(y.toString());
                expect(typeof fiveYear[y]).toBe('number');
            }
        });
    });
});
