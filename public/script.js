// 📥 DOM-element
const form = document.getElementById('postForm');
const input = document.getElementById('postInput');
const list = document.getElementById('postList');
const welcome = document.getElementById('welcome');
const nicknameInput = document.getElementById('nickname');

// 🔐 Hämta användarnamn från localStorage
const username = localStorage.getItem('username');
if (username) {
  if (welcome) {
    welcome.textContent = `Hej ${username}, välkommen tillbaka!`;
  }
  if (nicknameInput) {
    nicknameInput.value = username;
  }
}

// 📝 Ladda tidigare inlägg
const savedPosts = JSON.parse(localStorage.getItem('posts')) || [];
savedPosts.forEach(text => {
  const li = document.createElement('li');
  li.textContent = text;
  if (list) list.appendChild(li);
});

// 📨 Hantera nytt inlägg
if (form && input && list) {
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const text = input.value.trim();
    if (text) {
      const li = document.createElement('li');
      li.textContent = text;
      list.appendChild(li);

      savedPosts.push(text);
      localStorage.setItem('posts', JSON.stringify(savedPosts));
      input.value = '';
    }
  });
}

// 👤 Skapa användarprofil
function createUserProfile(name, age, gender, interests) {
  return {
    name,
    age,
    gender,
    interests,
    matches: [],
    profilePicture: ""
  };
}

// 🔐 Registrering, inloggning, utloggning
function registerUser(username, password) {
  const user = { username, password };
  localStorage.setItem('user_' + username, JSON.stringify(user));
  console.log(`Medlem ${username} är en ny registrerad medlem.`);
}

function loginUser(username, password) {
  const storedUser = localStorage.getItem('user_' + username);
  if (!storedUser) return false;
  const user = JSON.parse(storedUser);
  return user.password === password;
}

function logout() {
  localStorage.removeItem('username');
  window.location.href = 'login.html';
}

// 🖼️ Profilbild
function addProfilePicture(user, imageUrl) {
  user.profilePicture = imageUrl;
  console.log(`${user.name} har lagt till en profilbild.`);
}

// 📝 Uppdatera profil
function updateProfile(username, newInfo) {
  const storedUser = localStorage.getItem('user_' + username);
  if (!storedUser) return false;
  const user = JSON.parse(storedUser);
  Object.assign(user, newInfo);
  localStorage.setItem('user_' + username, JSON.stringify(user));
  console.log(`${username} har uppdaterat sin profil.`);
}

// 💘 Matchning
function findMatches(user, potentialMatches) {
  return potentialMatches.filter(match => {
    const sharedInterests = user.interests.filter(interest =>
      match.interests.includes(interest)
    );
    return sharedInterests.length > 0;
  });
}

function displayMatches(user) {
  console.log(`Matches for ${user.name}:`);
  user.matches.forEach(match => {
    console.log(`- ${match.name}, Age: ${match.age}, Interests: ${match.interests.join(', ')}`);
  });
}

// 📬 Meddelanden
function sendMessage(sender, receiver, message) {
  console.log(`Message from ${sender.name} to ${receiver.name}: ${message}`);
}

// 🔍 Filtrera användare
function filterUsers(users, minAge, maxAge, gender) {
  return users.filter(user =>
    user.age >= minAge &&
    user.age <= maxAge &&
    user.gender === gender
  );
}

// 🎲 Isbrytare
function getIceBreaker() {
  const questions = [
    "Om du fick resa vart som helst just nu, vart skulle du åka?",
    "Vilken film kan du se om och om igen?",
    "Vad skulle kunna vara en rolig fakta om dig?",
    "Vilken är din favoritfilm/bok?",
    "Vad har du för gömda talanger?",
    "Hur ser en perfekt dag ut för dig?",
    "Vad är det mest spontana du har gjort?",
    "Om du kunde ha en superkraft, vilken skulle det vara?",
    "Vad är ditt drömjobb?",
    "Vilken är din favoritmaträtt?",
    "Jag bjuder på fika! Vad ska finnas med i din beställning?"
  ];
  const index = Math.floor(Math.random() * questions.length);
  return questions[index];
}

// 👉 Swipe-funktion
function swipe(user, potentialMatch, direction) {
  if (direction === 'right') {
    user.matches.push(potentialMatch.name);
    console.log(`${user.name} gillade ${potentialMatch.name} ❤️`);
  } else {
    console.log(`${user.name} svepte bort ${potentialMatch.name} 👋`);
  }
}

// 💾 Lagring
function saveProfile(user) {
  localStorage.setItem('profile_' + user.name, JSON.stringify(user));
}

function loadProfile(name) {
  const data = localStorage.getItem('profile_' + name);
  return data ? JSON.parse(data) : null;
}

function clearProfiles() {
  localStorage.clear();
  console.log("Alla profiler har raderats.");
}

// 🌍 Globala användare
let currentUser = null;
let potentialMatch = createUserProfile("Alex", 34, "male", ["resor", "träning", "mat"]);

// 🖱️ DOM-händelser
window.handleRegister = function () {
  const name = document.getElementById("regName").value;
  const pass = document.getElementById("regPass").value;
  registerUser(name, pass);
  currentUser = createUserProfile(name, 30, "female", ["musik", "resor", "mat"]);
  saveProfile(currentUser);
  alert("Registrerad!");
}

window.handleLogin = function () {
  const name = document.getElementById("loginName").value;
  const pass = document.getElementById("loginPass").value;
  if (loginUser(name, pass)) {
    currentUser = loadProfile(name);
    alert("Inloggad!");
  } else {
    alert("Fel användarnamn eller lösenord.");
  }
}

window.handleAddImage = function () {
  const url = document.getElementById("profileImage").value;
  if (currentUser) {
    addProfilePicture(currentUser, url);
    saveProfile(currentUser);
    document.getElementById("imagePreview").innerHTML = `<img src="${url}" alt="Profilbild" />`;
  }
}

window.handleSwipe = function (direction) {
  if (currentUser) {
    swipe(currentUser, potentialMatch, direction);
    saveProfile(currentUser);
  }
}

window.showIceBreaker = function () {
  document.getElementById("icebreakerText").textContent = getIceBreaker();
}

/*** SOCKET.IO ***/
const socket = io();

const display = document.getElementById('chatDisplay');
console.log('Display hittad:', display);

// Hämta användarnamn från localStorage
const nickname = localStorage.getItem('username') || 'vän';
const currentRoom = 'Global'; // Vi gör detta dynamiskt i nästa steg

// Anslut till rummet
socket.emit('joinRoom', { room: currentRoom, nickname });

// Visa meddelanden i chatDisplay
socket.on('message', data => {
  const msg = document.createElement('p');
  msg.innerHTML = `<strong>${data.user}:</strong> ${data.text}`;
  document.getElementById('chatDisplay').appendChild(msg);
  document.getElementById('chatDisplay').scrollTop = document.getElementById('chatDisplay').scrollHeight;
});

// Uppdatera medlem
socket.on('updateMembers', members => {
  const list = document.getElementById('memberList');
  list.innerHTML = '';
  members.forEach(name => {
    const li = document.createElement('li');
    li.textContent = name;
    list.appendChild(li);
  });
});

// Medlem lämnar rum
socket.on('recentLeft', names => {
  const list = document.getElementById('recentList');
  list.innerHTML = '';
  names.forEach(name => {
    const li = document.createElement('li');
    li.textContent = name;
    list.appendChild(li);
  });
});

// Skicka meddelande
document.getElementById('chatForm').addEventListener('submit', function (e) {
  e.preventDefault();
  const text = document.getElementById('chatInput').value.trim();
  if (text) {
    socket.emit('chatMessage', { user: nickname, text });
    document.getElementById('chatInput').value = '';
  }
});

// Byt rum vid klick
document.querySelectorAll('#roomList li').forEach(li => {
  li.addEventListener('click', () => {
    const newRoom = li.dataset.room;
    socket.emit('joinRoom', { room: newRoom, nickname });
    document.querySelector('.room-list .active')?.classList.remove('active');
    li.classList.add('active');
    document.getElementById('chatDisplay').innerHTML = '';
  });
});

// Öppna privat chatt
document.querySelectorAll('#privateList li').forEach(li => {
  li.addEventListener('click', () => {
    const recipient = li.dataset.user;
    alert(`Privat chatt med ${recipient} (funktion kommer snart!)`);
    // Här kan du öppna en ny vy eller ruta för privatmeddelanden
  });
});
