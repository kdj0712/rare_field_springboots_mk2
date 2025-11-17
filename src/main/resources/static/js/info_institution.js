let map, infowindow, userPosition, service;
let markers = [];

function initMap() {
    const userLocationConsent = localStorage.getItem('userLocationConsent');
    const defaultPos = { lat: 37.5665, lng: 126.9780 };  // 서울의 기본 위치를 예시로 설정

    infowindow = new naver.maps.InfoWindow({
        anchorSize: new naver.maps.Size(20, 20)
    });
    
    if (userLocationConsent === 'granted' && navigator.geolocation) {
        requestLocation();
    } else if (userLocationConsent === null) {
        const confirmed = confirm("이 웹사이트는 위치 정보를 사용하여 보다 나은 서비스를 제공합니다. 위치 정보를 제공하시겠습니까?");

        if (confirmed) {
            localStorage.setItem('userLocationConsent', 'granted');
            document.getElementById('getLocation').style.display = 'block';
        } else {
            handleLocationError(false, defaultPos);
        }
    } else {
        handleLocationError(false, defaultPos);
    }

    // 이벤트 리스너 추가
    document.getElementById('getLocation').addEventListener('click', requestLocation);
}

function requestLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function (position) {
                const pos = new naver.maps.LatLng(
                    position.coords.latitude,
                    position.coords.longitude
                );

                sessionStorage.setItem('pos', `${position.coords.latitude},${position.coords.longitude}`);

                map = new naver.maps.Map('map', {
                    center: pos,
                    zoom: 16,
                    draggable: true,
                    zoomControl: true
                });

                displayMarkers(jsonResults);
            },
            function (error) {
                console.error("Error requesting location:", error);

                const defaultPos = new naver.maps.LatLng(37.5665, 126.9780);  // 서울의 기본 위치를 예시로 설정
                handleLocationError(true, defaultPos);
            }
        );
    } else {
        alert("이 브라우저에서는 위치 정보 사용이 지원되지 않습니다.");
    }
}

function handleLocationError(browserHasGeolocation, pos) {
    infowindow.setPosition(pos);
    infowindow.setContent(
        browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.'
    );

    if (map) {
        infowindow.open(map);
    } else {
        map = new naver.maps.Map('map', {
            center: pos,
            zoom: 14
        });
        infowindow.open(map);
    }
}

async function getLocationAndSubmit() {
    try {
        let yPos, xPos;

        await new Promise((resolve, reject) => {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    yPos = position.coords.latitude.toString();
                    xPos = position.coords.longitude.toString();
                    resolve({ latitude: yPos, longitude: xPos });
                },
                (error) => reject(error)
            );
        });

        // const positionString = ''.concat(yPos, ',', xPos);
        // document.getElementById('pos').value = positionString;

        // var posValue = document.getElementById('pos').value;
        // if (posValue && posValue !== ',' && posValue.split(',').length === 2) {
        //     document.getElementById('maps').submit();
        // } else {
        //     alert('유효한 위치 정보가 없습니다. 다시 시도해 주세요.');
        // }
    } catch (error) {
        alert('위치 정보를 가져오지 못했습니다. 다시 시도해 주세요.');
    }
}



// function callback(jsonResults, status) {
//     if (status === google.maps.places.PlacesServiceStatus.OK) {
//         displayMarkers(jsonResults);
//     }
// }


function showExcellentInfoPopup(index) {
    // 팝업에 표시할 우수 정보 내용을 직접 구성합니다.
    const excellentInfoElement = document.getElementById(`excellent-info-${index}`);
    const excellentInfoHTML = `<ul>${excellentInfoElement.innerHTML}</ul>`;
    const popupWindow = window.open("", "PopupWindow", "width=380,height=450,scrollbars=yes,resizable=yes");
    popupWindow.document.write(`
        <html>
        <head>
            <title>우수정보</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                    padding: 20px;
                    background-color: #f0f0f0;
                }
                ul {
                    list-style-type: disc;
                    padding-left: 20px;
                }
                li {
                    margin-bottom: 5px;
                }
                .popup-header {
                    font-size: 24px;
                    margin-bottom: 20px;
                    text-align: center;
                    color: #333;
                }
                .close-button {
                    display: block;
                    margin: 20px auto;
                    padding: 10px 20px;
                    font-size: 16px;
                    background-color: #ff6347;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }
                .close-button:hover {
                    background-color: #ff4500;
                }
            </style>
        </head>
        <body>
            <div class="popup-header">우수 정보</div>
            ${excellentInfoHTML}
            <button class="close-button" onclick="window.close()">닫기</button>
        </body>
        </html>
    `);
    popupWindow.document.close(); // 팝업 내용이 모두 작성된 후에 문서를 닫습니다.
}



// function displayMarkers(jsonResults) {
//     if (!jsonResults || jsonResults.length === 0) return;

//     jsonResults.forEach((result, index) => {
//         if (result.YPos && result.XPos) {
//             const marker = new google.maps.Marker({
//                 position: { lat: parseFloat(result.YPos), lng: parseFloat(result.XPos) },
//                 map: map,
//                 title: result.yadmNm ? result.yadmNm : `Marker ${index + 1}`
//             });

//             google.maps.event.addListener(marker, 'click', function () {
//                 infowindow.setContent(result.yadmNm ? result.yadmNm : `Marker ${index + 1}`);
//                 infowindow.open(map, marker);
//             });

//             markers.push(marker); // 마커 배열에 추가
//         }
//     });
// }

function displayMarkers(jsonResults) {
    if (!jsonResults || jsonResults.length === 0) return;

    jsonResults.forEach((result, index) => {
        if (result.YPos && result.XPos) {
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(
                    parseFloat(result.YPos),
                    parseFloat(result.XPos)
                ),
                map: map,
                title: result.yadmNm ?? `Marker ${index + 1}`
            });

            naver.maps.Event.addListener(marker, 'click', () => {
                infowindow.setContent(result.yadmNm ?? `Marker ${index + 1}`);
                infowindow.open(map, marker);
            });

            markers.push(marker);
        }
    });
}
// focusOnMap 함수 예시
function focusOnMap(lat, lng) {
    if (isNaN(lat) || isNaN(lng)) {
        return;
    }
    const pos = new naver.maps.LatLng(lat, lng);
    map.setCenter(pos);
    map.setZoom(18);
    // // 지도 중심을 지정된 좌표로 이동
    // map.setCenter(new google.maps.LatLng(lat, lng));
    // map.setZoom(18); // 줌 레벨 설정
}

window.onload = initMap;


document.addEventListener("DOMContentLoaded", function () {
    // 지도 초기화
    initMap();

    // URL에서 쿼리 파라미터 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('keyword');
    const pos = urlParams.get('pos');
    const currentPage = urlParams.get('currentPage');

    // 폼 입력 필드에 값 설정하기
    if (keyword !== null) {
        document.getElementById('keyword').value = keyword;
    }
    if (pos !== null && pos !== ',') {
        document.getElementById('pos').value = pos;
    }

    // 이벤트 리스너 추가
    document.getElementById('getLocation').addEventListener('click', getLocationAndSubmit);
});

function goToPage(pageNumber) {
    var form = document.getElementById('maps');
    if (form) {
        var keyword = document.querySelector('input[name="keyword"]').value;
        var pos = document.querySelector('input[name="pos"]').value;
        var baseUrl = form.action.split('?')[0];
        var queryString = `?currentPage=${pageNumber}&keyword=${encodeURIComponent(keyword)}&pos=${encodeURIComponent(pos)}`;
        window.location.href = baseUrl + queryString;
        // form.submit();
    } else {
        console.error("Form not found");
    }
}

// 페이지 로드 시 기존 값 설정
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has('keyword')) {
        document.getElementById('keyword').value = urlParams.get('keyword');
    }

    if (urlParams.has('pos')) {
        document.getElementById('pos').value = urlParams.get('pos');
    }
};
