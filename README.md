# TOPページ
rails: thanks/#index
js: javascript/packs/thanks_index.js
vue: {
  parent:         javascript/components/top/ThanksIndex.vue,
  child:          [ javascript/components/shared/Header.vue,
                    javascript/components/shared/NavMypage.vue,
                    javascript/components/shared/NavAll.vue,
                    javascript/components/shared/Contents.vue          
                  ],
  grandchildren:  [ javascript/components/shared/parts/NavBtn.vue

  ]
}

# 受信ページ
rails: receptions/#index
js: javascript/packs/receptions_index.js
vue: {
  parent: 
  child: 
}