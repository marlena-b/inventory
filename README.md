# Inventory

Welcome to the Inventory application. This is a Rails app built to handle and streamline inventory management for businesses. 
Remember, this project is a work in progress and I'm building it to learn Rails development. Your feedback is appreciated, and I hope this tool will be of use to you!

### Preview

Visit https://inventory-mb.fly.dev/ to see live preview of the app.

### Features

* **Adding and Managing Products:** Create, update, and delete products within your inventory system.

* **Managing Multiple Warehouses**: Manage your inventory in multiple locations. This feature enables you to add new warehouses, update their details, or remove them as needed.
  
* **Categorizing Products:** Categorize your products to organize your inventory better and find products more efficiently.

* **Tracking and Managing Stock:** Keep track of the stock available at each warehouse and access a full history of stock movements.

* **🆕 Low Stock Levels:** Customize and define low stock levels for individual products within your inventory system. This feature allows you to easily identify and monitor products that are nearing depletion, enabling timely restocking.

* **Transferring Stock between Locations:** Easily transfer stock between different locations. This feature handles the underlying data changes and updates your inventory accordingly.

* **Multi-User Support:** Our system supports multiple users. This allows different members of your team to manage inventory, helping distribute workload and enhance productivity.

### Installation

To get started with the Inventory Management Application, please follow these steps:

1. Clone the repository:
```
git clone https://github.com/marlena-b/inventory
```

2. Move to the project directory:
```
cd inventory
```

3. Install the necessary dependencies:
```
bundle install
```

4. Setup the database (make sure you have PostgreSQL up and running):
```
rails db:create
rails db:migrate
```

5. Seed the database with sample data (optional):
```
rails db:seed
```

6. Run the server:
```
rails server
```
Now you should be able to access the app on http://localhost:3000.

### Usage

Once the application is running, navigate to http://localhost:3000 on your web browser. From here, you can create an account, and then add, update, and manage your inventory and warehouses.

### Contributing

As this is a learning project, contributions, issues, and feature requests are welcome! Feel free to check the issues page to see if there's something you'd like to work on. If you have a feature request, please open an issue before making a pull request.

### License

This project is licensed under the MIT License.
