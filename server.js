const express = require('express');
const app = express();

// Define routes
app.get('/', (req, res) => {
  res.send('Hello, world! welcome to the CICD pipeline');
});

// Ensure the app listens on the correct port
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
