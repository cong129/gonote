require('dotenv').config();
const express = require('express');
const cors = require('cors');

const knexConfig = require('./knexfile');
const knex = require('knex')(knexConfig[process.env.NODE_ENV]);

NOTES_TABLE = 'notes';

const setupServer = () => {
  const app = express();

  app.use(express.json());
  //   CORSエラーの解消;
  app.use(cors());

  app.get('/notes/all-note-titles', async (req, res) => {
    try {
      const notesOnDB = await knex
        .select('*')
        .from(NOTES_TABLE)
        .orderBy('edit_time', 'desc');
      res.status(200).send(notesOnDB);
    } catch (err) {
      res.status(404).send(err);
    }
  });

  app.post('/notes/newItem', async (req, res) => {
    console.log(req.body);
    try {
      const result = await knex(NOTES_TABLE)
        .insert({
          title: req.body.title,
          edit_time: new Date(req.body.editTime),
          note_detail: req.body.note,
        })
        .returning('id');
      res.send(result);
    } catch (err) {
      res.status(404).send(err);
    }
  });

  app.delete('/notes/:id', async (req, res) => {
    try {
      console.log(req.params.id);
      await knex(NOTES_TABLE).where({ id: req.params.id }).del();
      res.send(200);
    } catch (err) {
      res.status(404).send(err);
    }
  });

  app.put('/notes/:id', async (req, res) => {
    let newData = { ...req.body };
    delete newData.id;
    try {
      const updatedId = await knex(NOTES_TABLE)
        .where({ id: req.params.id })
        .update(newData)
        .returning('id');
      res.send(updatedId);
    } catch (err) {
      res.status(404).send(err);
    }
  });

  return app;
};

module.exports = { setupServer };
