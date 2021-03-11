# テーブル設計

## users テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false |
| password              | string  | null: false |
| password_confirmation | string  | null: false |
| first_name            | string  | mull: false |
| last_name             | string  | null: false |
| first_name_kana       | string  | null: false |
| last_name_kana        | string  | null: false |
| date_of_birth         | integer | null: false |

### Association

- has_many :items
- has_many :purchases
- has_one  :addresses

## itemsテーブル

| Column           | Type             | Options                        |
| ---------------- | ---------------- | ------------------------------ |
| image            | Active Storage   | null: false                    |
| item_name        | string           | null: false                    |
| item_description | text             | null: false                    |
| category         | string           | null: false                    |
| status           | string           | mull: false                    |
| price            | integer          | null: false                    |
| user_id          | references       | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :purchases

## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | integer    | null: false                    |
| prefectures   | string     | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | mull: false                    |
| phone_number  | integer    | null: false                    |
| user_id       | references | null: false, foreign_key: true |

### Association

- has_many   :purchases
- belongs_to :user

## purchasesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| items_id       | references | null: false, foreign_key: true |
| addresses_id   | references | null: false, foreign_key: true |
| user_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :address
- belongs_to :user