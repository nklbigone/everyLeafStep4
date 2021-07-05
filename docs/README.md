# README
- User
  | Name            | Column  |
  |-----------------|---------|
  | user_id         | integer |
  | name            | string  |
  | email           | string  |
  | password_digest | string  |
  | company         | string  |
  | department      | string  |
  | admin           | string  |
  | gender          | integer |
  | birthday        | date    |
 

- Task

  | Name    | Column  |
  |---------|---------|
  | task_id | integer |
  | title   | string  |
  | status  | integer |
  | primary | integer |
  | content | text    |
  | enddate | date    |
  | user_id | integer |

- Label

  | Name       | Column  |
  |------------|---------|
  | label_id   | integer |
  | label_name | string  |

- Labeling
  | Name     | Column  |
  |----------|---------|
  | label_id | integer |
  | task_id  | integer |


## Herokuへのデプロイ手順
1. ログイン
>heroku login -i
2. Assetプリコンパイル
>rails assets:precompile RAILS_ENV=production
3. git add & git commit
>git add .
>git commit -m "init"
4. heroku create
>heroku create
5. buildpackを入れる
>heroku buildpacks:set heroku/ruby

>heroku buildpacks:add --index 1 heroku/nodejs
6. heroku stackを18に変更
>heroku stack:set heroku-18
7. heroku main (or master)にpush
8. デプロイ出来ない場合、下記platformを入れる
>bundle lock --add-platform x86_64-linux ※デプロイ出来ない場合

>bundle install --without production

>git commit -a -m "modify the Gemfile.lock"
9. Heroku main (or master)にpush
>git push heroku main( or master)
10. heroku内でマイグレーション
>heroku run rails db:migrate
11. herokuサーバーを再起動
>heroku restart
12. アクセスして動作確認