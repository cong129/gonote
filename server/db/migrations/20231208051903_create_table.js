/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  knex.schema.dropTable('notes');
  return knex.schema.createTable('notes', (tb) => {
    tb.increments('id').primary();
    tb.string('title');
    tb.dateTime('edit_time');
    tb.text('note_detail');
  });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
  return knex.schema.dropTable('notes');
};
