const dotenv = require('dotenv');
const path = require('path');

const envFile = `.env.${process.env.NODE_ENV}`;
dotenv.config({ path: path.resolve(process.cwd(), envFile) });

