const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);

app.use(express.static('public'));

io.on('connection', socket => {
  console.log('En användare anslöt');

  socket.on('joinRoom', room => {
    socket.join(room);
    socket.room = room;
  });

  socket.on('chatMessage', data => {
    io.to(socket.room).emit('message', {
      user: data.user,
      text: data.text
    });
  });

  socket.on('disconnect', () => {
    console.log('Användare lämnade');
  });
});

http.listen(3000, () => {
  console.log('Servern körs på http://localhost:3000');
});
