Customer.destroy_all
Customer.reset_pk_sequence
Merchant.destroy_all
Merchant.reset_pk_sequence
Item.destroy_all
Item.reset_pk_sequence
Invoice.destroy_all
Invoice.reset_pk_sequence
InvoiceItem.destroy_all
InvoiceItem.reset_pk_sequence
Transaction.destroy_all
Transaction.reset_pk_sequence

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(: name: 'Star Wars' },: name: 'Lord of t, Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.load_customers('db/data/customers.csv')
Merchant.load_merchants('db/data/merchants.csv')
Item.load_items('db/data/items.csv')
Invoice.load_invoices('db/data/invoices.csv')
InvoiceItem.load_invoice_items('db/data/invoice_items.csv')
Transaction.load_transactions('db/data/transactions.csv')
