import {firestore, initializeApp} from "firebase-admin";
import * as functions from "firebase-functions";
import {utcToZonedTime} from "date-fns-tz";
// const axios = require('axios').default;

initializeApp();

export const scheduledFunction = functions.pubsub.schedule("every 5 minutes")
    .onRun(async () => {
        console.log("Checking for programs that need run...");
        const serverTime = new Date();
        console.log(`Current server date and time is ${serverTime}`);
        const dayOfWeek = serverTime.getUTCDay();
        console.log(`Day of week on server is ${dayOfWeek}`);
        const users = await firestore().collection("users").get();
        for (let i = 0; i < users.size; i++) {
            const user = await users.docs[i].ref.get();
            const userData = user.data();
            if (userData == undefined) {
                continue;
            }
            console.log(`Checking user ${userData.customer_id}`);
            const userTimezone = userData.time_zone;
            if (userTimezone != null && userTimezone != undefined) {
                console.log(`Found user timezone of ${userTimezone}`);
                const userTime = utcToZonedTime(serverTime, userTimezone);
                console.log(`User time is ${userTime}`);
                const programs = await user.ref.collection('programs').get();
                for (let j = 0; j < programs.size; j++) {
                    const program = await programs.docs[j].ref.get();
                    const programData = program.data();
                    if (programData == undefined) {
                        continue;
                    }
                    const programName = programData.name;
                    const programShouldRun = programData.frequency.includes(userTime.getDay());
                    console.log(`${programName} should run: ${programShouldRun}`);
                    if (programShouldRun) {
                        const runs = await program.ref.collection("runs").get();
                        for (let k = 0; k < runs.size; k++) {
                            const run = await runs.docs[k].ref.get();
                            const runData = run.data();
                            if (runData == undefined) {
                                continue;
                            }
                            const startTime = runData.start_time;
                            const splits = startTime.split(":", 2);
                            const runTime = new Date(userTime.getTime());
                            runTime.setHours(splits[0]);
                            runTime.setMinutes(splits[1]);
                            const timeDifference = runTime.getTime() - userTime.getTime();
                            if (timeDifference < 0) {
                                // TODO(brandon): Need to check field for `last_run`
                                console.log(`Run for zone ${runData.z_id} already happened or we missed it`);
                            } else if (timeDifference < 300000) {
                                console.log(`Need to run zone ${runData.z_id} now`);
                                // TODO(brandon): Actually run the zone?
                                // const userApiKey = userData.api_key;
                                // try {
                                //     const { data } = await axios.get(`http://api.hydrawise.com/api/v1/statusschedule.php?api_key=${userApiKey}`);
                                //     console.log(data);
                                // } catch (error) {
                                //     console.log(error);
                                // }
                            } else {
                                console.log(`Will run zone ${runData.z_id} in ${timeDifference / 1000} seconds`);
                            }

                        }
                    }
                }
            }
        }
        return null;
    });
