# テーブル設計

## users テーブル

| Column                | Type    | Options                      |
| --------------------- | ------- | ---------------------------- |
| nickname              | string  | null: false                  |
| email                 | string  | null: false uniqueness: true |
| encrypted_password    | string  | null: false                  |
| first_name            | string  | mull: false                  |
| last_name             | string  | null: false                  |
| first_name_kana       | string  | null: false                  |
| last_name_kana        | string  | null: false                  |
| date_of_birth         | integer | null: false                  |

### Association

- has_many :items
- has_many :purchases
- has_one  :addresses

## itemsテーブル

| Column             | Type             | Options                        |
| ------------------ | ---------------- | ------------------------------ |
| item_name          | string           | null: false                    |
| item_description   | text             | null: false                    |
| category_id        | integer          | null: false                    |
| status_id          | integer          | mull: false                    |
| price              | integer          | null: false                    |
| delivery_fee_id    | integer          | null: false                    |
| delivery_source_id | integer          | null: false                    |
| delivery_date_id   | integer          | null: false                    |
| user               | references       | null: false, foreign_key: true |



### Association

- belongs_to :user
- has_one    :purchases

## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefectures_id| integer    | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchases     |references  | null: false, foreign_key: true |

### Association

- has_many   :purchases
- belongs_to :purchases

## purchasesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| items_id       | references | null: false, foreign_key: true |
| user_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one    :address