/* global $ */
/* global google*/
/* global navigator*/
function get_area_name(latLng_now){
  // 座標から住所名を取得
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({latLng: latLng_now, language: "ja"}, function(results, status){
    if(status == google.maps.GeocoderStatus.OK){
      $("#area_name").html(results[0].formatted_address+'付近');
    } else {
     console.log(status);
     // エラーの場合
    }   
  });
}


function get_location() {
    
  // gps取得開始
  navigator.geolocation.getCurrentPosition(
     function(pos) {
        // gps 取得成功
     // google map 初期化
     
     if (pos.coords.accuracy > 500) {
         get_location();
         return;
     }
     
     console.log(pos);
     var gmap = new google.maps.Map($('#gmap').get(0), {
         center: new google.maps.LatLng(35, 135),
         mapTypeId: google.maps.MapTypeId.ROADMAP,
         zoom: 17
     });
 
     // 現在位置にピンをたてる
     var currentPos = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude);
     var currentMarker = new google.maps.Marker({
            position: currentPos
     });
     currentMarker.setMap(gmap);
 
   // 誤差を円で描く
      new google.maps.Circle({
         map: gmap,
         center: currentPos,
         radius: pos.coords.accuracy, // 単位はメートル
         strokeColor: '#0088ff',
         strokeOpacity: 0.8,
         strokeWeight: 1,
         fillColor: '#0088ff',
         fillOpacity: 0.2
        });
 
     // 現在地にスクロールさせる
     gmap.panTo(currentPos);
     get_area_name(currentPos);
     console.log(pos.coords.latitude);
     $(".lat").html(pos.coords.latitude);
     $(".lng").html(pos.coords.longitude);
     $(".accurate").html(pos.coords.accuracy);
      }, function() {
         // gps 取得失敗
         $('#gmap').text('GPSデータを取得できませんでした');
           return false;
      }
//      ,
       // 位置取得の動作オプションを設定
//      {
//        timeout : 6000,
//        maximumAge : 600000,
//        enableHighAccuracy: true
//      }
    );
}

$(document).ready(function(){

  var controller = $("body").data("controller").replace(/\//, "_");
  if (controller != "static_pages") {
    return;
  }
     
   // gps に対応しているかチェック
  if (! navigator.geolocation) {
      $('#gmap').html('GPSに対応したブラウザでお試しください');
        return false;
  }
 
  $('#gmap').html('GPSデータを取得します...');
  get_location(); 
   
});