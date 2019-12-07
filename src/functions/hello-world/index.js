// Hello world function handler
// Force function update
export default async(e, ctx, cb) => {
    try {
        console.log(`Hello World`)
    } catch (err) {
        console.error(err.message)
    }
}