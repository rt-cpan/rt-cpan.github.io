/*
 * ActiveMQviaJNDI.java
 *
 * Created on October 17, 2007, 11:13 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package activemqviajndi;

import javax.jms.Connection;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NameAlreadyBoundException;
import javax.naming.NamingException;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.log4j.Logger;

/**
 *
 * @author lloy0076
 */
public class ActiveMQNative {
    Logger logger = Logger.getLogger("ActiveMQviaJNDI");
    
    public ActiveMQNative() {
        logger.info("Starting...");
        
        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory("tcp://localhost:61616");
        
        Connection connection = null;
        try {
            connection = factory.createConnection();
            
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Queue dest = session.createQueue("activemq/perl");
            MessageProducer producer = session.createProducer(dest);
            
            int counter = 0;
            
            TextMessage message = null;
            
            producer.send(session.createTextMessage("clear"));
            int the_max = 250;
            
            while (counter++ < the_max) {
                String m = Integer.valueOf(counter).toString();
                message = session.createTextMessage(m);
                producer.send(message);
            }
            
            message = session.createTextMessage("check");
            producer.send(message);
            
            message = session.createTextMessage("max" + the_max);
            producer.send(message);
            
//            message = session.createTextMessage("dump");
//            producer.send(message);
        } catch (JMSException ex) {
            logger.fatal(ex.toString());
            System.exit(1);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (JMSException ex) {
                    ex.printStackTrace();
                }
            }
        }
        
        logger.info("Finishing...");
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new ActiveMQNative();
    }
}