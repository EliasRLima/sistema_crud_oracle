import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Principal {
    
	
	
    public static void main(String[] args) {
    	
    	String server = "localhost";
        String port = "1521";               
        String database = "apl_bd2";
        String user = "system";
        String passwd = "erl";
        
        String erro = "";
        String msg_erro = "";
    	
        try {
            String url = "jdbc:oracle:thin:@" + server + ":" + port + ":" + database;

            // Abre-se a conexão com o Banco de Dados
            Connection con = DriverManager.getConnection(url, user, passwd);
            
            CallableStatement ctsmt = con.prepareCall("{call apl_bd2.pck_cadastro_inc.executa(p_numero => ?, p_tipo => ?, p_nome => ?, p_email => ?, p_telefone => ?, p_erro => ?, p_msg_erro => ?)}"); 
            ctsmt.setString(1, "12312312312"); 
            ctsmt.setString(2, "1"); 
            ctsmt.setString(3, "Luis do Pneu"); 
            ctsmt.setString(4, "luizpneupirelli@email.com"); 
            ctsmt.setString(5, "98 99999-9999"); 
            ctsmt.execute(); 
            erro = ctsmt.getString(6);
            msg_erro = ctsmt.getString(7);
            ctsmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if( erro.equals("N")){
        	System.out.println("Foi inserido com sucesso.");
        }else {
        	System.out.println("Nao foi possivel dar insert no banco. " + msg_erro);
        }
    	
	}
}


