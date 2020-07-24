using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Linq;
using System.Text;
namespace MOMRouter
{
    class Program
    {
        static void Main(string[] args)
        {
           
            var factory = new ConnectionFactory() { HostName = "localhost"};
            using (var connection = factory.CreateConnection())
            using (var channelWO = connection.CreateModel())
            {
                channelWO.QueueDeclare(queue: "WO",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                var consumerWO = new EventingBasicConsumer(channelWO);
                consumerWO.Received += async (model, ea) =>
                {
                    var bodyWO = ea.Body.ToArray();
                    var messageWO = Encoding.UTF8.GetString(bodyWO.ToArray());
                    Console.WriteLine(" [x] Received {0}", messageWO);
                    Notificacao n = new Notificacao();
                    n.id = 0;
                    n.message = messageWO;
                    await n.CreateNotificacao();
                    using (var connectionOW = factory.CreateConnection())
                    using (var channelfunout = connectionOW.CreateModel())
                    {
                        channelfunout.ExchangeDeclare(exchange: "OW", type: ExchangeType.Fanout);

                        var message = messageWO;

                        var body = Encoding.UTF8.GetBytes(message);
                        channelfunout.BasicPublish(exchange: "OW",
                                             routingKey: "",    
                                             basicProperties: null,
                                             body: body);
                        Console.WriteLine(" [x] Sent {0}", message);
                    }
                };
                channelWO.BasicConsume(queue: "WO",
                                     autoAck: true,
                                     consumer: consumerWO);

                Console.WriteLine(" Press [enter] to exit.");
                Console.ReadLine();
            } 

            var factoryMO = new ConnectionFactory() { HostName = "localhost" };
            using (var connectionMO = factory.CreateConnection())
            using (var channelMO = connectionMO.CreateModel())
            {
                channelMO.QueueDeclare(queue: "MO",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                var consumerMO = new EventingBasicConsumer(channelMO);
                consumerMO.Received += async (model, ea) =>
                {
                    var bodyMO = ea.Body.ToArray();
                    var messageMO = Encoding.UTF8.GetString(bodyMO.ToArray());
                    Console.WriteLine(" [x] Received {0}", messageMO);
                    Notificacao n = new Notificacao();
                    n.id = 0;
                    n.message = messageMO;
                    await n.CreateNotificacao();
                    using (var connectionOM = factoryMO.CreateConnection())
                    using (var channelfunout = connectionOM.CreateModel())
                    {
                        channelfunout.ExchangeDeclare(exchange: "OM", type: ExchangeType.Fanout);

                        var message = messageMO;

                        var body = Encoding.UTF8.GetBytes(message);
                        channelfunout.BasicPublish(exchange: "OM",
                                             routingKey: "",
                                             basicProperties: null,
                                             body: body);
                        Console.WriteLine(" [x] Sent {0}", message);
                    }
                };
                channelMO.BasicConsume(queue: "OM",
                                     autoAck: true,
                                     consumer: consumerMO);

                Console.WriteLine(" Press [enter] to exit.");
                Console.ReadLine();
            }
                

        }

       
    }
}
