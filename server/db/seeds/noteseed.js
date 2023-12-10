/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.seed = async function (knex) {
  // Deletes ALL existing entries
  await knex('notes').del();
  await knex('notes').insert([
    {
      title: 'test_memo0',
      edit_time: new Date(),
      note_detail: 'test_memo0\ntest detail0\nthird sentence0',
    },
    {
      title: 'test_memo1',
      edit_time: new Date(),
      note_detail: 'test_memo1\ntest detail1\nthird sentence1',
    },
    {
      title: 'test_memo3',
      edit_time: new Date(),
      note_detail: 'test_memo2\ntest detail2\nthird sentence2',
    },
  ]);
};
