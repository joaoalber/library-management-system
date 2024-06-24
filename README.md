# Library Management System

### A project to manage a library being as an admin or a member

This readme provides the necessary instructions to run this project

## Functionalities

- Users are able to register, log in, and log out
- Librarian users are able to add, edit, or delete books
- Users are able to search for a book by title, author, or genre
- Member users are able to borrow a book if it's available (They can't borrow the
same book multiple times)
- The system track when a book was borrowed and when it's due (2 weeks from the
borrowing date)
- Librarian users are able to mark a book as returned.
- Librarians have a dashboard showing total books, total borrowed books, books due today, and
a list of members with overdue books
- Members have a dashboard showing books they've borrowed, their due dates, and any
overdue books
- RESTful API that allows CRUD operations for books and borrowings

## Setup

1. Clone this repo into your directory preference
2. Navigate to the created folder
3. This project was written using the latest ruby version which is the Ruby 3.3.3, you can `install the ruby 3.3.3 from https://rvm.io/` or any source of your truth
4. Now that you have the Ruby in your machine, run `bundle install` to install the necessary deps
5. Run `bundle exec rails assets:precompile` to have the CSS setup
6. Run `bundle exec rails db:setup` in order to have the db schema available + running the seed to have available test data
8. Run `rails s` to run the server (the default port that `rails s` points is `localhost:3000`)

### Creds for librarian user: `admin@mail.com` - `123456` 
### Creds for member user: `member@mail.com` - `123456` 

## Used Technologies

- RSpec
- Tailwind CSS
- Ruby
- SQLite
- Grape
- Rails

## Testing

In order to run the project tests you can run `bundle exec rspec`, all spec files are under /spec directory


## Things to be improved (WIP)

- API autorization / authentication with an API key (only the app includes auth)
- Mobile friendly (most functionalities are not focused in mobile devices)
- A spec suite more robust (trying to cover 100% of the functionalities)
- UI improvements (there are a few inconsistencies between some screens)
- Front-End inputs fields in order to improve user experience
- Better use of components in both BE & FE (a few things were repeated)

## Books API

API calls should be made under `/api/v1/:resource` endpoint, e.g.: `localhost:3000/api/v1/books`

### Create a Book

**POST** `/books`

Create a new book with the specified parameters.

**Parameters:**

- `title` (required, String): Title of the book.
- `author` (required, String): Author of the book.
- `genre` (required, String): Genre of the book.
- `isbn` (required, String): ISBN of the book.
- `total_copies` (optional, Integer): Total copies of the book.

---

### Update a Book
**PATCH** `/books`

Update an existing book identified by :id with the specified parameters.

**Parameters:**

- `id` (required, Integer): id of the book.
- `title` (optional, String): Updated title of the book.
- `author` (optional, String): Updated author of the book.
- `genre` (optional, String): Updated genre of the book.
- `isbn` (optional, String): Updated ISBN of the book.
- `total_copies` (optional, Integer): Updated total copies of the book.

---

### Delete a Book
**DELETE** `/books`

**Parameters:**

- `id` (required, Integer): id of the book.

Delete a book identified by :id

---

### Retrieve All Books
**GET** `/books`

Retrieve a list of all books

---

### Retrieve a Book
**GET** `/books/:id`

Retrieve details of a specific book identified by :id.

---

## Borrowings API

API calls should be made under `/api/v1/:resource` endpoint, e.g.: `localhost:3000/api/v1/borrowings`

### Create a Borrowing

**POST** `/borrowings`

Create a new borrowing with the specified parameters.

**Parameters:**

- `user_id` (required, Integer): ID of the user borrowing the book.
- `book_id` (required, Integer): ID of the book being borrowed.

---

### Update a Borrowing
**PATCH** `/borrowings`

Update an existing borrowing identified by :id with the specified parameters.

**Parameters:**

- `id` (required, Integer): id of the borrowing.
- `user_id` (optional, Integer): Updated ID of the user borrowing the book.
- `book_id` (optional, Integer): Updated ID of the book being borrowed.
- `return_at` (optional, DateTime): Updated return date for the book.

---

### Delete a Borrowing
**DELETE** `/borrowings`

- `id` (required, Integer): id of the borrowing.

Delete a borrowing identified by :id.

---

### Retrieve All Borrowings
**GET** `/borrowings`

Retrieve a list of all borrowings.

---

### Retrieve a Borrowing
**GET** `/borrowings/:id`

Retrieve details of a specific borrowing identified by :id.

---

## Error Responses

- `404 Not Found`: Resource not found. Returned when trying to access a resource that does not exist.
- `400 Bad Request`: Invalid request parameters. Returned when the request parameters are not valid.
- `405 Not Allowed`: Probably you are passing the resource_id into the URL. Instead of passing the resource_id into the URL, use the request body.
- `422 Unprocessable Entity`: Record validation failed. Returned when attempting to create or update a record with - invalid attributes.
- `500 Internal Server Error`: Generic server error. Returned when an unexpected server error occurs.
