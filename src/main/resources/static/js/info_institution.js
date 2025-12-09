let map, infowindow, userPosition, service;
let markers = [];

// ============================================
// 1. 지도 초기화 - 조건부 실행
// ============================================
function initMap() {
    // 지도 컨테이너가 존재하는지 확인
    const mapContainer = document.getElementById('map');
    if (!mapContainer) {
        console.error('Map container not found');
        return;
    }

    const userLocationConsent = localStorage.getItem('userLocationConsent');
    const defaultPos = { lat: 37.5665, lng: 126.9780 };

    // InfoWindow 초기화
    infowindow = new naver.maps.InfoWindow({
        anchorSize: new naver.maps.Size(20, 20)
    });
    
    // 위치 권한에 따른 처리
    if (userLocationConsent === 'granted' && navigator.geolocation) {
        requestLocation();
    } else if (userLocationConsent === null) {
        const confirmed = confirm("이 웹사이트는 위치 정보를 사용하여 보다 나은 서비스를 제공합니다. 위치 정보를 제공하시겠습니까?");

        if (confirmed) {
            localStorage.setItem('userLocationConsent', 'granted');
            requestLocation();
        } else {
            localStorage.setItem('userLocationConsent', 'denied');
            handleLocationError(false, new naver.maps.LatLng(defaultPos.lat, defaultPos.lng));
        }
    } else {
        // 위치 권한이 거부된 경우
        handleLocationError(false, new naver.maps.LatLng(defaultPos.lat, defaultPos.lng));
    }
}

// ============================================
// 2. 위치 권한 요청
// ============================================
function requestLocation() {
    if (!navigator.geolocation) {
        console.warn("Geolocation not supported");
        const defaultPos = new naver.maps.LatLng(37.5665, 126.9780);
        handleLocationError(false, defaultPos);
        return;
    }

    navigator.geolocation.getCurrentPosition(
        function (position) {
            const pos = new naver.maps.LatLng(
                position.coords.latitude,
                position.coords.longitude
            );

            // 위치 정보 저장
            sessionStorage.setItem('pos', `${position.coords.latitude},${position.coords.longitude}`);
            
            const posInput = document.getElementById('pos');
            if (posInput) {
                posInput.value = `${position.coords.latitude},${position.coords.longitude}`;
            }

            // 지도 생성
            createMap(pos, 16);

            // 사용자 위치 마커 추가
            addUserLocationMarker(pos);

            // ⭐ 핵심: jsonResults가 있을 때만 마커 표시
            displayMarkersIfAvailable();
        },
        function (error) {
            console.error("위치 정보 요청 실패:", error.message);
            const defaultPos = new naver.maps.LatLng(37.5665, 126.9780);
            handleLocationError(true, defaultPos);
        }
    );
}

// ============================================
// 3. 지도 생성 함수 (중복 생성 방지)
// ============================================
function createMap(center, zoom) {
    // 이미 지도가 생성되어 있으면 중심만 이동
    if (map) {
        map.setCenter(center);
        map.setZoom(zoom);
        return;
    }

    // 새 지도 생성
    map = new naver.maps.Map('map', {
        center: center,
        zoom: zoom,
        draggable: true,
        zoomControl: true,
        zoomControlOptions: {
            position: naver.maps.Position.TOP_RIGHT
        }
    });

    console.log('Map created successfully');
}

// ============================================
// 4. 사용자 위치 마커 추가
// ============================================
function addUserLocationMarker(pos) {
    new naver.maps.Marker({
        position: pos,
        map: map,
        title: '현재 위치',
        icon: {
            content: '<div style="background: #4285F4; width: 20px; height: 20px; border-radius: 50%; border: 3px solid white; box-shadow: 0 2px 5px rgba(0,0,0,0.3);"></div>',
            anchor: new naver.maps.Point(10, 10)
        },
        zIndex: 1000 // 다른 마커보다 위에 표시
    });
}

// ============================================
// 5. 위치 오류 처리
// ============================================
function handleLocationError(browserHasGeolocation, pos) {
    const message = browserHasGeolocation 
        ? '위치 정보를 가져올 수 없습니다.' 
        : '브라우저가 위치 정보를 지원하지 않습니다.';

    console.warn(message);

    // 지도 생성
    createMap(pos, 14);

    // 정보창 표시
    infowindow.setContent(`<div style="padding:10px;">${message}</div>`);
    infowindow.setPosition(pos);
    infowindow.open(map);

    // ⭐ 핵심: jsonResults가 있을 때만 마커 표시
    displayMarkersIfAvailable();
}

// ============================================
// 6. 조건부 마커 표시 - 안전성 핵심!
// ============================================
function displayMarkersIfAvailable() {
    // ⭐ jsonResults가 정의되어 있고, 배열이며, 비어있지 않을 때만 실행
    if (typeof jsonResults !== 'undefined' && 
        Array.isArray(jsonResults) && 
        jsonResults.length > 0) {
        
        console.log(`Displaying ${jsonResults.length} markers`);
        displayMarkers(jsonResults);
    } else {
        console.log('No search results to display - showing empty map');
        // 검색 결과가 없으면 아무것도 하지 않음 (빈 지도 유지)
    }
}

// ============================================
// 7. 폼 제출 처리
// ============================================
function setupFormSubmit() {
    const form = document.getElementById('maps');
    if (!form) {
        console.warn('Form not found');
        return;
    }

    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const keyword = document.getElementById('keyword').value.trim();
        if (!keyword) {
            alert('검색어를 입력해주세요.');
            document.getElementById('keyword').focus();
            return;
        }

        // 위치 정보 가져오기 시도 (선택적)
        try {
            const position = await new Promise((resolve, reject) => {
                if (!navigator.geolocation) {
                    reject(new Error('Geolocation not supported'));
                    return;
                }
                navigator.geolocation.getCurrentPosition(resolve, reject, {
                    timeout: 5000,
                    maximumAge: 60000
                });
            });

            const yPos = position.coords.latitude.toString();
            const xPos = position.coords.longitude.toString();
            document.getElementById('pos').value = `${yPos},${xPos}`;
            console.log('Position updated:', yPos, xPos);
            
        } catch (error) {
            console.log('위치 정보 사용 불가, 기존 값 또는 빈 값으로 검색:', error.message);
            // 위치 정보를 가져올 수 없어도 검색은 진행
        }

        // 폼 제출
        console.log('Submitting form with keyword:', keyword);
        form.submit();
    });
}

// ============================================
// 8. 우수정보 모달
// ============================================
function showExcellentInfoPopup(index) {
    const excellentInfoElement = document.getElementById(`excellent-info-${index}`);
    
    if (!excellentInfoElement) {
        console.error(`Element with id 'excellent-info-${index}' not found`);
        return;
    }

    // 모달이 없으면 생성
    if (!document.getElementById('excellentInfoModal')) {
        createExcellentInfoModal();
    }

    const modal = document.getElementById('excellentInfoModal');
    const modalBody = document.getElementById('modalExcellentInfo');
    
    // 내용 안전하게 복사
    modalBody.innerHTML = '';
    const contentClone = excellentInfoElement.cloneNode(true);
    contentClone.style.display = 'block';
    modalBody.appendChild(contentClone);
    
    // 모달 표시
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function createExcellentInfoModal() {
    const modalHTML = `
        <div id="excellentInfoModal" style="
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        ">
            <div style="
                background: white;
                width: 90%;
                max-width: 500px;
                max-height: 80vh;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            ">
                <div style="
                    padding: 20px;
                    background: #f8f9fa;
                    border-bottom: 1px solid #dee2e6;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                ">
                    <h3 style="margin: 0; font-size: 20px; color: #333;">우수 정보</h3>
                    <button onclick="closeExcellentInfoModal()" style="
                        background: none;
                        border: none;
                        font-size: 28px;
                        cursor: pointer;
                        color: #666;
                        line-height: 1;
                        padding: 0;
                        width: 30px;
                        height: 30px;
                    ">&times;</button>
                </div>
                <div id="modalExcellentInfo" style="
                    padding: 20px;
                    overflow-y: auto;
                    max-height: calc(80vh - 140px);
                ">
                </div>
                <div style="
                    padding: 15px 20px;
                    border-top: 1px solid #dee2e6;
                    text-align: center;
                ">
                    <button onclick="closeExcellentInfoModal()" style="
                        padding: 10px 30px;
                        font-size: 16px;
                        background-color: #ff6347;
                        color: white;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                    ">닫기</button>
                </div>
            </div>
        </div>
    `;
    
    document.body.insertAdjacentHTML('beforeend', modalHTML);
    
    // ESC 키로 닫기
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeExcellentInfoModal();
        }
    });
    
    // 오버레이 클릭으로 닫기
    document.getElementById('excellentInfoModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeExcellentInfoModal();
        }
    });
}

function closeExcellentInfoModal() {
    const modal = document.getElementById('excellentInfoModal');
    if (modal) {
        modal.style.display = 'none';
        document.body.style.overflow = '';
    }
}

// ============================================
// 9. 마커 표시
// ============================================
function displayMarkers(jsonResults) {
    if (!map) {
        console.error('Map not initialized');
        return;
    }
    
    if (!jsonResults || jsonResults.length === 0) {
        console.log('No results to display');
        return;
    }

    // 기존 마커 제거
    markers.forEach(marker => marker.setMap(null));
    markers = [];

    let validMarkersCount = 0;

    jsonResults.forEach((result, index) => {
        if (result.YPos && result.XPos) {
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(
                    parseFloat(result.YPos),
                    parseFloat(result.XPos)
                ),
                map: map,
                title: result.yadmNm || `Marker ${index + 1}`
            });

            naver.maps.Event.addListener(marker, 'click', () => {
                infowindow.setContent(`
                    <div style="padding:10px; min-width:150px;">
                        <h4 style="margin:0 0 5px 0;">${result.yadmNm || '정보 없음'}</h4>
                        <p style="margin:0; font-size:12px; color:#666;">${result.addr || ''}</p>
                    </div>
                `);
                infowindow.open(map, marker);
            });

            markers.push(marker);
            validMarkersCount++;
        }
    });

    console.log(`Displayed ${validMarkersCount} markers out of ${jsonResults.length} results`);

    // 모든 마커가 보이도록 지도 범위 조정
    if (markers.length > 0) {
        const bounds = new naver.maps.LatLngBounds();
        markers.forEach(marker => bounds.extend(marker.getPosition()));
        map.fitBounds(bounds);
    }
}

// ============================================
// 10. 특정 위치로 지도 포커스
// ============================================
function focusOnMap(lat, lng, index) {
    if (isNaN(lat) || isNaN(lng)) {
        console.error('Invalid coordinates:', lat, lng);
        return;
    }
    
    if (!map) {
        console.error('Map not initialized');
        return;
    }
    
    const pos = new naver.maps.LatLng(lat, lng);
    map.setCenter(pos);
    map.setZoom(18);

    // 해당 마커의 정보창 열기
    if (markers[index]) {
        naver.maps.Event.trigger(markers[index], 'click');
    }
}

// ============================================
// 11. 페이지네이션
// ============================================
function goToPage(pageNumber) {
    const form = document.getElementById('maps');
    if (!form) {
        console.error("Form not found");
        return;
    }

    const keyword = document.getElementById('keyword').value;
    const pos = document.getElementById('pos').value;
    const baseUrl = form.action || window.location.pathname;
    
    const queryString = `?currentPage=${pageNumber}&keyword=${encodeURIComponent(keyword)}&pos=${encodeURIComponent(pos)}`;
    
    console.log('Navigating to page:', pageNumber);
    window.location.href = baseUrl + queryString;
}

// ============================================
// 12. 페이지 로드 시 초기화 - 안전성 보장!
// ============================================
document.addEventListener("DOMContentLoaded", function () {
    console.log('DOM loaded, initializing...');
    
    // URL 파라미터 읽기
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('keyword');
    const pos = urlParams.get('pos');
    const currentPage = urlParams.get('currentPage');

    // ⭐ 검색 결과가 있는지 확인
    const hasSearchResults = keyword && typeof jsonResults !== 'undefined' && jsonResults.length > 0;
    
    if (hasSearchResults) {
        console.log(`Search results found: ${jsonResults.length} items for keyword "${keyword}"`);
    } else {
        console.log('Initial page load - no search results');
    }

    // 폼 필드에 값 설정
    const keywordInput = document.getElementById('keyword');
    const posInput = document.getElementById('pos');
    
    if (keywordInput && keyword) {
        keywordInput.value = keyword;
    }
    
    if (posInput && pos && pos !== ',') {
        posInput.value = pos;
    }

    // 폼 제출 이벤트 설정
    setupFormSubmit();

    // 지도 초기화 (조건부 마커 표시 포함)
    initMap();
    
    console.log('Initialization complete');
});