#StockCard
トレーディングカードの取引サイトです。  
需要が少なく流通していないカードをリストから取引可能にする点を意識して開発しました。  
カードリストから選択し、販売・購入できます。  

*URL*  
https://stockcard20210427.herokuapp.com/  
ログイン画面のメールアドレスとパスワードに「１」を入力すると管理者としてログインできます。  

*使用技術*  
Ruby 2.6.3p62  
Ruby on Rails 5.2.4.5  
javascript  
jquery（payjp）  
sqllite 1.3.6(開発環境)  
posgresql（本番環境）  
heroku  

*機能一覧*  
ログイン・会員登録  
入札・購入  
出品・販売  
取引画面  
送付先情報の登録  
クレジット登録・決済（payjp）  
振込申請  
振込申請の管理  

*テスト・リファクタリング*  
rubocop  
railsbestpractice  
brakeman  
rspecを現在実装中です。  

