const pkg = require('../package.json')
const year = new Date().getFullYear()

const banner = `/*!
 * BootstrapVue ${pkg.version}
 *
 * @link ${pkg.homepage}
 * @source https://github.com/desicahq/desikit
 * @copyright (c) 2016-${year} BootstrapVue
 * @license ${pkg.license}
 * https://github.com/desicahq/desicahq/blob/master/LICENSE
 */
`

module.exports = banner
