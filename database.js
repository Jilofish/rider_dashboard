import mysql from 'mysql2'

import dotenv from 'dotenv'
dotenv.config()

const pool = mysql
  .createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  })
  .promise()

export async function getOrderList() {
  const [rows] = await pool.query("SELECT * FROM OrderList")
  return rows[0]
}

// Asynchronous function to retrieve ongoing orders for a rider
export async function getOngoingOrders(riderId) {
      const [rows] = await pool.query('SELECT * FROM OngoingOrders WHERE rider_id = ?', [riderId])
      return rows
}

export async function sendMessage(messageContent) {
  try {
      // Insert the message into the MySQL messages table
      await pool.query('INSERT INTO messages (message_content) VALUES (?)', [messageContent]);

      console.log('Message inserted into the database:', messageContent);

      console.log('Message sent successfully');
  } catch (error) {
      console.error('Error sending message:', error);
  }
}