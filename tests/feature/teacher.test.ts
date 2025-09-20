describe("Feature Guru", () => {
    describe("Role: Admin", () => {
        it.todo("Harus mengembalikan daftar guru berupa nama dan email dengan pagination 10");
        it.todo("Harus mengembalikan daftar guru berdasarkan filter tertentu dan search");
        it.todo("Tidak boleh mengembalikan daftar guru jika page number < 1");

        it.todo("Harus dapat menambahkan guru berupa nama, email, dan username");
        it.todo("Tidak boleh menambahkan guru dengan email yang sudah digunakan");
        it.todo("Tidak boleh menambahkan guru dengan username yang sudah digunakan");
        it.todo("Tidak boleh menambahkan guru jika field nama, email, atau username kosong");

        it.todo("Harus mengembalikan detail guru berupa nama, username, email, dan profile berdasarkan ID");
        it.todo("Tidak boleh mengembalikan detail guru jika ID tidak ditemukan");

        it.todo("Harus dapat mengupdate data guru berupa nama, email, dan username berdasarkan ID");
        it.todo("Tidak boleh mengupdate guru dengan email invalid format");
        it.todo("Tidak boleh mengupdate guru jika ID tidak ditemukan");

        it.todo("Harus dapat menghapus data guru berdasarkan ID");
        it.todo("Tidak boleh menghapus guru jika ID tidak ditemukan");

    });

    describe("Role: Guru", () => {
        it.todo("Harus mengembalikan detail guru berupa nama, username, email, dan profile berdasarkan ID");
        it.todo("Tidak boleh mengakses detail guru lain berdasarkan ID");
        it.todo("Tidak boleh mengupdate guru lain berdasarkan ID");

        it.todo("Harus dapat mengupdate data guru berupa nama, email, dan username berdasarkan ID");
        it.todo("Tidak boleh mengupdate data guru dengan email invalid format");

    });

    describe("Authorization & Authentication", () => {
        it.todo("Tidak boleh mengakses endpoint guru tanpa token");
        it.todo("Tidak boleh mengakses endpoint guru dengan token invalid");
        it.todo("Tidak boleh mengakses endpoint role Admin jika login sebagai Guru");
    });

});
