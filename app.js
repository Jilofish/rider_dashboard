import express from 'express'

import {
    getOrderList,
    getOngoingOrders,
    sendMessage
} from './database.js'

const app =express()
app.use(express.json())


app.get('/orders', async (req, res) => {
    try {
        const orderList = await getOrderList()
        res.send(orderList);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' })
    }
})


// Express route to retrieve ongoing orders for a rider
app.get('/ongoing-orders/:riderId', async (req, res) => {
    const riderId = req.params.riderId;
    try {
        const ongoingOrders = await getOngoingOrders(riderId);
        res.json(ongoingOrders);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
})


// Route handler to handle accepting or rejecting orders by riders
app.post('/orders/:orderId/:action', async (req, res) => {
    const orderId = req.params.orderId;
    const action = req.params.action;

    try {
        // Simulate checking rider availability and workload
        await new Promise(resolve => setTimeout(resolve, 1000)) // Simulate a delay of 1 second
        
        // Log the action and order ID
        console.log(`Order ${orderId} has been ${action}ed by the rider`)
        
        // Respond with success status
        res.sendStatus(200)
    } catch (error) {
        // Respond with error status
        console.error('Error handling order:', error)
        res.sendStatus(500)
    }
})

// Express route to send a message
app.post('/send-message', async (req, res) => {
    const { messageContent } = req.body;

    try {
        // Send the message
        await sendMessage(messageContent);

        // Respond with success status
        res.status(200).json({ message: 'Message sent successfully' });
    } catch (error) {
        // Respond with error status
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
});



app.use ((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send({ error: 'Internal server error' })
})

app.listen(8080, () => {
    console.log('Server is running on port 8080')
})