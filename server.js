import express from 'express';
import http from 'http';
import path from 'path';
import { Server } from 'socket.io';
import cors from 'cors';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import open from 'open';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
const server = http.createServer(app);
const io = new Server(server);

app.use(cors());
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
    console.log('Meddelande mottaget:', data); // För felsökning
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