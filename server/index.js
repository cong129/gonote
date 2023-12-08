const { setupServer } = require('./server');
const server = setupServer();
const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log(`listening on port : ${PORT}`);
  console.log('localServer :', 'http://localhost:3000');
});
