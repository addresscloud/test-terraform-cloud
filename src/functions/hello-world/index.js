// Hello world function handler
// testing with git sha
export default async(e, ctx, cb) => {
    try {
        console.log(`Hello World`)
    } catch (err) {
        console.error(err.message)
    }
}