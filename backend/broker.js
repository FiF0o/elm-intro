const { ServiceBroker } = require("moleculer");


const broker = new ServiceBroker();

broker.loadService("./services/greeter.service");

broker.start()
  .then(() => broker.call('greeter.hello'))
  .then(res => console.log(res))
  .catch(e => console.log(e));