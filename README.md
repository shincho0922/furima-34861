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
| date_of_birth         | date    | null: false                  |

### Association

- has_many :items
- has_many :purchases

## itemsテーブル

| Column             | Type             | Options                        |
| ------------------ | ---------------- | ------------------------------ |
| name               | string           | null: false                    |
| description        | text             | null: false                    |
| category_id        | integer          | null: false                    |
| status_id          | integer          | mull: false                    |
| price              | integer          | null: false                    |
| delivery_fee_id    | integer          | null: false                    |
| delivery_source_id | integer          | null: false                    |
| delivery_date_id   | integer          | null: false                    |
| user               | references       | null: false, foreign_key: true |



### Association

- belongs_to :user
- has_one    :purchase

## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefectures_id| integer    | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      |references  | null: false, foreign_key: true |

### Association

- belongs_to :purchase

## purchasesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item           | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
