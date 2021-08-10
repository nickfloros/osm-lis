
const OVERPASS_API_URL = process.env['OVERPASS_API_URL'] || 'http://192.168.1.232:49154/api/interpreter';

const overPassUrl = new URL(OVERPASS_API_URL);

export {
  OVERPASS_API_URL,
  overPassUrl
}
