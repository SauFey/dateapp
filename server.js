const cors = require('cors');
const http = require('http');
const open = require('open');
const { Server } = require('socket.io');
const express = require('express');
const path = require('path');

// Detta gör att Express serverar statiska filer från "public"-mappen
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

io.on('connection', socket => {
  console.log('En användare anslöt');

  socket.on('joinRoom', ({ room, nickname }) => {
    socket.join(room);
    socket.room = room;
    socket.nickname = nickname;

    io.to(room).emit('message', {
      user: '🌙 LunaBot',
      text: `${nickname} har gått med i ${room}`
    });
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

server.listen(0, () => {
    const adress = server.address();
    const url = `http://localhost:${adress.port}`;
    console.log(`Servern körs på ${url}`);
    open(url); //Öppnar webbläsaren automatiskt
});