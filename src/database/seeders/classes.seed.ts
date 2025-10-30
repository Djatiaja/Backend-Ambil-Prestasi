import { randWord } from "@ngneat/falso";
import prisma from "..";

export const matkuls = ["PPK", "Pancasila", "Agama", "Bahasa Indonesia"]

export const classesSeed = async () => {

    console.log("\n🌱 Seeding classes...");

    for (let i = 0; i < 10; i++) {
        await prisma.class.create({
            data: {
                name: randWord(),
                description: randWord({ length: 30 }).join(" "),
                image_path: "files/public/placeholder.png",
                categoryId: 1
            }
        });
    }


    console.log("✅ Classes seeded.");
};
