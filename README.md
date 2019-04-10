# PetsSeeder

Create pets and insert them into your local sqlite3 instance.

## Installation

clone this repo then run `bundle install` and `rake install`

## Usage

in the project folder run the following command

```sh
pets_seeder
```

Now you can start an sqlite3 instance with the data like this

```sh
sqlite3 db
```

Now in your sqlite3 session you have a `pets` table ready to query.

```sql
SELECT * FROM pets WHERE type IS "dog";

-- 6|Donn|1|dog
-- 17|Elly|3|dog
-- 27|Shirley|1|dog
-- 30|Darrell|3|dog
-- 43|Kendrick|1|dog
-- 58|Don|3|dog
-- 69|Antoine|3|dog
-- 79|Dwayne|2|dog
-- 82|Byron|2|dog
-- 94|Pa|2|dog
-- 96|Shirleen|1|dog
-- 103|Trula|1|dog
-- 104|Brett|1|dog
-- 114|Trudi|2|dog
-- 116|Andrea|1|dog
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
