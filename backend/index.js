import express from 'express';
import Moralis from 'moralis';
import dotenv from 'dotenv';
import cors from 'cors';

const app = express();
const port=5001;
dotenv.config();

app.use(cors());
app.use(express.json());

const MORALIS_API_KEY=process.env.MORALIS_API_KEY;

//Our Endpoint
Moralis.start(
    {
        apiKey: MORALIS_API_KEY,

    }).then(() => {
        app.listen(port, () => {
            console.log('Listening for API Calls')
        })
    })
