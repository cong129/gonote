require('dotenv').config();
const express = require('express');
const cors = require('cors');

const knexConfig = require('./knexfile');
const knex = require('knex')(knexConfig[process.env.NODE_ENV]);

const setupServer = () => {
  const app = express();

  app.use(express.json());
  //   CORSエラーの解消;
  app.use(cors());

  app.get('/all-note-titles', async (req, res) => {
    try {
      const getMemoTitle = await knex
        .select(['id', 'title', 'edit_time'])
        .from('notes')
        .orderBy('edit_time', 'desc');
      res.status(200).send(getMemoTitle);
    } catch (err) {
      res.status(404).send(err);
    }
  });

  return app;
};

module.exports = { setupServer };
