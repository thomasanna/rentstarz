 // This example adds a search box to a map, using the Google Place Autocomplete
      // feature. People can enter geographical searches. The search box will return a
      // pick list containing a mix of places and predicted search terms.

      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">


    var searchBox;
    var placeSearch, autocomplete;
    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        neighborhood: 'long_name',
        locality: 'long_name',
        sublocality_level_1: 'long_name',
        administrative_area_level_1: 'long_name',
        country: 'long_name',
        postal_code: 'short_name'
    };
    var markers1 = [];


    function initAutocomplete() {


        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: latitude, lng: longitude},
          zoom: 8,
          mapTypeId: 'roadmap',
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        var myLatlng = new google.maps.LatLng(latitude, longitude);
        /*var markers = new google.maps.Marker({

              map: map,
              position: myLatlng,
              draggable: true,
              animation: google.maps.Animation.DROP


        });

        markers1.push(markers); */
        var geocoder = geocoder = new google.maps.Geocoder();

        // Create the search box and link it to the UI element.
        var input = document.getElementById('pac-input1');
        var searchBox = new google.maps.places.SearchBox(input);
    //    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        // Bias the SearchBox results towards current map's viewport.
        map.addListener('bounds_changed', function() {
          searchBox.setBounds(map.getBounds());
        });


        // Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener('places_changed', function() {

        var element =  document.getElementById('location');
        if (typeof(element) != 'undefined' && element != null)
        {
          document.getElementById("location").checked = false;
        }


           // Clear out the old markers.
         markers1.forEach(function(marker) {
            marker.setMap(null);
          });
          markers1 = [];
          var places = searchBox.getPlaces();
          if (places.length == 0) {
            return;
          }

        //var markers = [];
          // For each place, get the icon, name and location.
          var bounds = new google.maps.LatLngBounds();
          places.forEach(function(place) {//console.log(place);
            if (!place.geometry) {
              console.log("Returned place contains no geometry");
              return;
            }
            var icon = {
              url: place.icon,
              size: new google.maps.Size(71, 71),
              origin: new google.maps.Point(0, 0),
              anchor: new google.maps.Point(17, 34),
              scaledSize: new google.maps.Size(25, 25)
            };



            // Create a marker for each place.
             var markers = new google.maps.Marker({

              map: map,
              icon: icon,
              title: place.name,
              position: place.geometry.location,
              draggable: true,
              animation: google.maps.Animation.DROP


                 });

         markers1.push(markers);

            google.maps.event.addListener(markers, "dragend", function (e) {
                    var lat, lng, address;
                    geocoder.geocode({ 'latLng': markers.getPosition() }, function (results, status) {
                      if (status == google.maps.GeocoderStatus.OK) {
                            lat = markers.getPosition().lat();
                            lng = markers.getPosition().lng();

                            document.getElementById('street_number').value ="";
                            document.getElementById('route').value ='';
                            document.getElementById('neighborhood').value ='';
                            document.getElementById('locality').value ='';
                            document.getElementById('sublocality_level_1').value ='';
                            document.getElementById('administrative_area_level_1').value ='';
                            document.getElementById('country').value ='';
                            document.getElementById('postal_code').value ='';
                            document.getElementById('latitude').value ='';
                            document.getElementById('longitude').value ='';

                           // address1 = results[0].address_components; console.log(address1);
                             for (var i = 0; i < results[0].address_components.length; i++) {

                                  var addressType = results[0].address_components[i].types[0];
                                  if (componentForm[addressType]) {
                                  var val = results[0].address_components[i][componentForm[addressType]]; //alert(results[0].address_components[4][componentForm[addressType]]);
                                  document.getElementById(addressType).value = val;
                                  
                                 }
                             }

                            document.getElementById('latitude').value =lat;
                            document.getElementById('longitude').value =lng;
                            address = results[0].formatted_address;
                           // alert("Latitude: " + lat + "\nLongitude: " + lng + "\nAddress: " + address);

                           var country = document.getElementById('country').value;
                           var state = document.getElementById('administrative_area_level_1').value;
                           var city = document.getElementById('locality').value;
                           if(city == ''){
                             var city = document.getElementById('sublocality_level_1').value;
                           }
                           var neighborhood = document.getElementById('neighborhood').value;

                           document.getElementById('pac-input1').value = city + ',' + state +','+ country;

                      }
                });


                });



            if (place.geometry.viewport) {
              // Only geocodes have viewport.
              bounds.union(place.geometry.viewport);
            } else {
              bounds.extend(place.geometry.location);
            }

        document.getElementById('street_number').value ="";
        document.getElementById('route').value ='';
        document.getElementById('locality').value ='';
        document.getElementById('sublocality_level_1').value ='';
        document.getElementById('neighborhood').value ='';
        document.getElementById('administrative_area_level_1').value ='';
        document.getElementById('country').value ='';
        document.getElementById('postal_code').value ='';
        document.getElementById('latitude').value ='';
        document.getElementById('longitude').value ='';
        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
       // console.log(place.address_components);
        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          if (componentForm[addressType]) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType).value = val;
           
            if(addressType=='sublocality_level_1'){
				if(document.getElementById('locality').value == ''){
					
					 document.getElementById('locality').value =val;
				}
				document.getElementById('sublocality_level_1').value =val;
		    }
			else{
				document.getElementById(addressType).value = val;
			}
			
          }
        }
         $('.select_prefernce_location_popup #set_to_usa').prop('checked', false); 
         $('#locationPreferenceDeviceModal #set_to_usa').prop('checked', false); 
         document.getElementById("set_to_usa").checked = false;
           lat = place.geometry.location.lat();
           lng = place.geometry.location.lng();
           document.getElementById('latitude').value =lat;
           document.getElementById('longitude').value =lng;

           if((document.getElementById('neighborhood').value == '') && ( document.getElementById('postal_code').value != '') && (lat != '' && lng!='' ) ){	   
		
			   downloadUrl("https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true", function(data) {	   
				 
				  var obj = JSON.parse(data.response);
				  for(var i=0;i < obj.results[0].address_components.length;i++){					  
					  var addressType = obj.results[0].address_components[i].types[0];
					  if(addressType  == 'neighborhood' || addressType  == 'postal_code'){
					  var val = obj.results[0].address_components[i][componentForm[addressType]];
					      document.getElementById(addressType).value = val;
				      }					  
				  }				 
			   });			   
		   }
        });
        map.fitBounds(bounds);
        });
        }


function deleteMarkers() {
        clearMarkers();
        markers = [];
      }

function setMapOnAll(map) {alert(markers.length);
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }

function clearMarkers() {
        setMapOnAll(null);
      }


// autocomplete location on inputfield without map


 function initAutocomplete1() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete1')),
            {types: ['geocode']});

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }
      // autocomplete location on inputfield without map in location preference device
 function initAutocomplete2() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete2')),
            {types: ['geocode']});

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }
 function initAutocomplete3() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete3')),
            {types: ['geocode']});

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }
 function initAutocomplete4() {
        // Create the autocomplete object, restricting the search to geographical
        // location types.
        autocomplete = new google.maps.places.Autocomplete(
            /** @type {!HTMLInputElement} */(document.getElementById('autocomplete4')),
            {types: ['geocode']});

        // When the user selects an address from the dropdown, populate the address
        // fields in the form.
        autocomplete.addListener('place_changed', fillInAddress);
      }

      function fillInAddress() {
		 clearfields();
        // Get the place details from the autocomplete object.
        var place = autocomplete.getPlace();

        for (var component in componentForm) {
          document.getElementById(component).value = '';
          document.getElementById(component).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
          var addressType = place.address_components[i].types[0];
          if (componentForm[addressType]) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType).value = val;
            if(addressType=='sublocality_level_1'){
				if(document.getElementById('locality').value == ''){
					
					 document.getElementById('locality').value =val;
				}
				document.getElementById('sublocality_level_1').value =val;
		    }
			else{
				document.getElementById(addressType).value = val;
			}
            
            
            
          }
        }
        lat = place.geometry.location.lat();
        lng = place.geometry.location.lng();
        document.getElementById('latitude').value =lat;
        document.getElementById('longitude').value =lng;
        if((document.getElementById('neighborhood').value == '') && ( document.getElementById('postal_code').value != '') && (lat != '' && lng!='' ) ){	   
		downloadUrl("https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=true", function(data) {	   
				 
				  var obj = JSON.parse(data.response);
				  for(var i=0;i < obj.results[0].address_components.length;i++){					  
					  var addressType = obj.results[0].address_components[i].types[0];
					  if(addressType  == 'neighborhood' || addressType  == 'postal_code'){
					  var val = obj.results[0].address_components[i][componentForm[addressType]];
					      document.getElementById(addressType).value = val;
				      }					  
				  }				 
			   });	
        }
        
        
        
      }
function downloadUrl(url, callback) {
	var request = window.ActiveXObject ?
	new ActiveXObject('Microsoft.XMLHTTP') :
	new XMLHttpRequest;

	request.onreadystatechange = function() {
	if (request.readyState == 4) {
	request.onreadystatechange = doNothing;
	callback(request, request.status);
	}
	};

	request.open('GET', url, true);
	request.send(null);
}
function doNothing(){}

function clearfields(){
	    document.getElementById('street_number').value ="";
        document.getElementById('route').value ='';
        document.getElementById('locality').value ='';
        document.getElementById('sublocality_level_1').value ='';
        document.getElementById('neighborhood').value ='';
        document.getElementById('administrative_area_level_1').value ='';
        document.getElementById('country').value ='';
        document.getElementById('postal_code').value ='';
        document.getElementById('latitude').value ='';
        document.getElementById('longitude').value ='';
	
}
