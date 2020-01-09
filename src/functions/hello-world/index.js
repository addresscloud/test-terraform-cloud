// Hello world function handler
console.log(`Initialising...`)
export default async(e, ctx, cb) => {
    try {
        console.log(`Hello World`)
        console.log(`Complete`)
    } catch (err) {
        console.error(err.message)
    }
}