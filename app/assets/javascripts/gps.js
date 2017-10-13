/* global $ */
/* global google*/
/* global navigator*/

function get_area_name(latLng_now){
  // 座標から住所名を取得
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({latLng: latLng_now, language: "ja"}, function(results, status){
    if(status == google.maps.GeocoderStatus.OK){
      $("#area_name").html(results[0].formatted_address+'付近');
      $("#micropost_area").val(results[0].formatted_address);
    } else {
     console.log(status);
     // エラーの場合
    }   
  });
}

function set_maker(gmap, pos) {
     console.log(gmap);
     console.log(pos);
     // 現在位置にピンをたてる
     var currentPos = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

     var currentMarker = new google.maps.Marker({
            position: currentPos
     });

     currentMarker.setMap(gmap);
     var ratio = gmap.getZoom();
     return currentPos;
}


function get_map_render_wo_area(pos, accflag) {
    // accflag 誤差円を描くflag

    console.log(pos);  
    var gmap = new google.maps.Map($('#gmap').get(0), {
         center: new google.maps.LatLng(35, 135),
         mapTypeId: google.maps.MapTypeId.ROADMAP,
         zoom: 17
     });
 
    currentPos = set_maker(gmap, pos);
     // 現在位置にピンをたてる
 
   if (accflag === true) {
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
    }
 
     // 現在地にスクロールさせる
     gmap.panTo(currentPos);
     return [gmap, currentPos];
}

function get_map_render(pos) {
    ret = get_map_render_wo_area(pos, true);
    get_area_name(ret[1]);  // ret[1] is currentpos
    return ret[0];          // ret[0] is gmap
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
         get_map_render(pos);
         $("#micropost_lat").val(pos.coords.latitude);
         $("#micropost_lng").val(pos.coords.longitude);
         $("#micropost_accuracy").val(pos.coords.accuracy);
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