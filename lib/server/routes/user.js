const express = require("express");
const userRouter = express.Router();
//const auth = require("../middlewares/auth");
const Order = require("../models/order");
const { Product } = require("../models/product");
const User = require("../models/user");

///
userRouter.post("/api/add-to-cart", async (req, res) => {
    try {
        const { userId, id } = req.body;

        const product = await Product.findById(id);

        let user = await User.findById(userId);

        if (user.cart.length == 0) {user.cart.push({ product, quantity: 1 });}
        else {
            let isProductFound = false;

            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {isProductFound = true;}
            }

            if (isProductFound) {
                let product3 = user.cart.find((product2) => product2.product._id.equals(product._id));
                product3.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }

        user = await user.save();

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

///
userRouter.delete("/api/remove-from-cart/:id/:userId", async (req, res) => {
    try {
        const { id, userId } = req.params;

        const product = await Product.findById(id);

        let user = await User.findById(userId);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if (user.cart[i].quantity == 1) {user.cart.splice(i, 1);}
                else {user.cart[i].quantity -= 1;}
            }
        }

        user = await user.save();

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

///
userRouter.post("/api/save-user-address", async (req, res) => {
    try {
        const { userId, address } = req.body;

        let user = await User.findById(userId);

        user.address = address;

        user = await user.save();

        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

///
userRouter.post("/api/order", async (req, res) => {
    try {
        const { userId, cart, totalPrice, address } = req.body;

        let products = [];

        for (let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);

            if (product.quantity >= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({ product, quantity: cart[i].quantity });
                await product.save();
            }
            else {
                return res.status(400).json({ msg: `${product.name} is out of stock!` });
            }

        }

        let user = await User.findById(userId);
        user.cart = [];
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: userId,
            orderedAt: new Date().getTime(),
        });

        order = await order.save();

        res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

///
userRouter.get("/api/orders/me/:userId", async (req, res) => {
    try {
        const { userId } = req.params;

        const orders = await Order.find({ userId: userId });

        res.json(orders);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = userRouter;
