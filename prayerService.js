import { Coordinates, CalculationMethod, PrayerTimes, SunnahTimes } from 'adhan';

export const getPrayerTimes = (latitude, longitude, date = new Date()) => {
  try {
    const coordinates = new Coordinates(latitude, longitude);
    const params = CalculationMethod.MuslimWorldLeague();
    const prayerTimes = new PrayerTimes(coordinates, date, params);
    
    return {
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    };
  } catch (error) {
    console.error('Prayer time error:', error);
    return null;
  }
};

export const getNextPrayer = (prayerTimes) => {
  if (!prayerTimes) return null;
  
  const now = new Date();
  const prayers = [
    { name: 'الفجر', nameEn: 'Fajr', time: prayerTimes.fajr },
    { name: 'الشروق', nameEn: 'Sunrise', time: prayerTimes.sunrise },
    { name: 'الظهر', nameEn: 'Dhuhr', time: prayerTimes.dhuhr },
    { name: 'العصر', nameEn: 'Asr', time: prayerTimes.asr },
    { name: 'المغرب', nameEn: 'Maghrib', time: prayerTimes.maghrib },
    { name: 'العشاء', nameEn: 'Isha', time: prayerTimes.isha },
  ];
  
  const next = prayers.find(p => p.time > now);
  return next || prayers[0];
};

export const formatPrayerTime = (date) => {
  if (!date) return '--:--';
  return date.toLocaleTimeString('ar-SA', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true,
  });
};

export const getTimeUntilPrayer = (prayerTime) => {
  if (!prayerTime) return null;
  const now = new Date();
  const diff = prayerTime - now;
  if (diff < 0) return null;
  
  const hours = Math.floor(diff / (1000 * 60 * 60));
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((diff % (1000 * 60)) / 1000);
  
  return { hours, minutes, seconds, totalMs: diff };
};

export const getHijriDate = (date = new Date()) => {
  const hijri = new Intl.DateTimeFormat('ar-SA-u-ca-islamic', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  }).format(date);
  return hijri;
};

export const getGregorianDate = (date = new Date()) => {
  return new Intl.DateTimeFormat('ar', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  }).format(date);
};

export const calculateQiblaDirection = (latitude, longitude) => {
  const makkahLat = 21.3891;
  const makkahLng = 39.8579;
  
  const lat1 = latitude * (Math.PI / 180);
  const lat2 = makkahLat * (Math.PI / 180);
  const deltaLng = (makkahLng - longitude) * (Math.PI / 180);
  
  const y = Math.sin(deltaLng) * Math.cos(lat2);
  const x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(deltaLng);
  
  let bearing = Math.atan2(y, x) * (180 / Math.PI);
  bearing = (bearing + 360) % 360;
  
  return bearing;
};
