package es.upm.dit.cnvr.pfinal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MainBankTest {
	
	public MainBankTest() {
		
	}
	
	@SuppressWarnings("unused")
	public static void main(String[] args) throws IOException {
				
		// Creamos un banco.
		Bank bank = new Bank(false, 3);
		
		List<Client> clientList = new ArrayList<Client>();
		List<Account> accountList = new ArrayList<Account>();
		
		clientList.add(new Client("Christene Muncy", "82224465K"));
		clientList.add(new Client("Darcel Dollar", "30820137S"));
		clientList.add(new Client("Marissa Daley", "27946319C"));
		clientList.add(new Client("Palma Jeffers", "48502944Y"));
		clientList.add(new Client("Luciano Serrano", "30121563Y"));
		clientList.add(new Client("Mina Irvine", "00842948N"));
		clientList.add(new Client("Ferdinand Hinds", "42184904Q"));
		clientList.add(new Client("Trula Irvin", "00871894X"));
		clientList.add(new Client("Masako Wayne", "75664764Z"));
		clientList.add(new Client("Zulema Ledbetter", "82174371B"));
		clientList.add(new Client("Ludivina Dexter", "41390848C"));
		clientList.add(new Client("Oscar Huber", "48038159U"));
		clientList.add(new Client("Lizette Neumann", "86954692R"));
		clientList.add(new Client("Debbi Mcneil", "04975800Y"));
		clientList.add(new Client("Hien Trout", "32448149V"));
		clientList.add(new Client("Lavern Olds", "50200014W"));
		clientList.add(new Client("Nanci Negrete", "28592937B"));
		clientList.add(new Client("Jude Cooke", "26247097V"));
		clientList.add(new Client("Prudence Casas", "51742688Q"));
		clientList.add(new Client("Magnolia Couch", "45835818R"));
		clientList.add(new Client("Shantay Velazquez", "01495524H"));
		clientList.add(new Client("Verla Breeden", "99713629Y"));
		clientList.add(new Client("Obdulia Council", "87444223Z"));
		clientList.add(new Client("Blair Mortensen", "37973320S"));
		clientList.add(new Client("Boyce Osorio", "41166627Z"));
		clientList.add(new Client("Micha Styles", "50455539X"));
		clientList.add(new Client("Nida Hynes", "92016764W"));
		clientList.add(new Client("Caitlyn Gomes", "12210486W"));
		clientList.add(new Client("Stevie Blevins", "26997678C"));
		clientList.add(new Client("Hai Moen", "31276879S"));
		clientList.add(new Client("Stefany Gallardo", "02023714O"));
		clientList.add(new Client("Coretta Parr", "11177496O"));
		clientList.add(new Client("Chi Tomlinson", "98363777K"));
		clientList.add(new Client("Margene Engle", "42963945Z"));
		clientList.add(new Client("Tamisha Lefebvre", "26219161Y"));
		clientList.add(new Client("Selina Atchison", "23369568T"));
		clientList.add(new Client("Sol Renteria", "58465960D"));
		clientList.add(new Client("Eldridge Fuentes", "26848882L"));
		clientList.add(new Client("Ashton Pippin", "50307302L"));
		clientList.add(new Client("Jonna Whitley", "38264532L"));
		clientList.add(new Client("Rosalina Looney", "11117960I"));
		clientList.add(new Client("Nyla Nicholson", "36807535B"));
		clientList.add(new Client("Evie Delacruz", "62162338N"));
		clientList.add(new Client("Herlinda Mcculloch", "12669216N"));
		clientList.add(new Client("Jules Gleason", "35637898A"));
		clientList.add(new Client("Emogene Raymond", "35695939P"));
		clientList.add(new Client("Alline Dockery", "42754617G"));
		clientList.add(new Client("Sharyn Battle", "36828668F"));
		clientList.add(new Client("Ta Pepper", "54505888Y"));
		clientList.add(new Client("Danica Triplett", "30575372M"));
		clientList.add(new Client("Melodee Ervin", "42282907R"));
		clientList.add(new Client("Denese Lara", "13958083A"));
		clientList.add(new Client("Hildegarde Burge", "64419883Y"));
		clientList.add(new Client("Eliz Word", "75598722B"));
		clientList.add(new Client("Harlan Dube", "82496300E"));
		clientList.add(new Client("Raven Benefield", "13806848D"));
		clientList.add(new Client("Janiece Darnell", "33019718B"));
		clientList.add(new Client("Marcell Ashford", "28698049S"));
		clientList.add(new Client("Hwa Olmstead", "67746314Y"));
		clientList.add(new Client("Terina Lyle", "86354736S"));
		clientList.add(new Client("Mitchel Crowley", "31442413C"));
		clientList.add(new Client("Denis Ha", "26227587Z"));
		clientList.add(new Client("Noelia Orozco", "61130695D"));
		clientList.add(new Client("Gema Kurtz", "26390242X"));
		clientList.add(new Client("Selma Byers", "41393720K"));
		clientList.add(new Client("Dortha Keane", "00393597D"));
		clientList.add(new Client("Bebe Stowe", "51462126C"));
		clientList.add(new Client("Porter Pridgen", "94154728S"));
		clientList.add(new Client("Kandi Small", "03697968W"));
		clientList.add(new Client("Mitsue Harden", "75441782Z"));
		clientList.add(new Client("Marya Batchelor", "97648197L"));
		clientList.add(new Client("Lenora Pleasant", "24251671C"));
		clientList.add(new Client("Holley Culbertson", "84707669Q"));
		clientList.add(new Client("August Welker", "21972088F"));
		clientList.add(new Client("Monika Sanborn", "36447310P"));
		clientList.add(new Client("Hong Schaffer", "44566226R"));
		clientList.add(new Client("Nila Espinal", "12524462Y"));
		clientList.add(new Client("Roberto Bragg", "31757336I"));
		clientList.add(new Client("Amado Mares", "34437977I"));
		clientList.add(new Client("Reynalda Samples", "04744417B"));
		clientList.add(new Client("Linwood Do", "03646342B"));
		clientList.add(new Client("Dong Whitlow", "02479166A"));
		clientList.add(new Client("Katharyn Bynum", "96833937X"));
		clientList.add(new Client("Mohamed Escobar", "03480822G"));
		clientList.add(new Client("Rashida Loy", "70779890C"));
		clientList.add(new Client("Karleen Amos", "52879611A"));
		clientList.add(new Client("Olevia Garmon", "31999335T"));
		clientList.add(new Client("Libbie Corley", "26067832K"));
		clientList.add(new Client("Libby Pulley", "67473608A"));
		clientList.add(new Client("Magdalene Oshea", "82349167U"));
		clientList.add(new Client("Letitia Canada", "29880289I"));
		clientList.add(new Client("Arden Stoddard", "05293406D"));
		clientList.add(new Client("Li Alfaro", "42687622F"));
		clientList.add(new Client("Eulalia Saldana", "95251167Y"));
		clientList.add(new Client("Verena Edmond", "26610726C"));
		clientList.add(new Client("Clora Hager", "35098871R"));
		clientList.add(new Client("Loria Munson", "64735438I"));
		clientList.add(new Client("Renea Hand", "66012261D"));
		clientList.add(new Client("Carmelina Chastain", "25663493Y"));
		clientList.add(new Client("Alta Porterfield", "24027039P"));

		for(Client a : clientList){
			boolean cl = bank.createClient(a.getName(), a.getDNI());
			try {
				Thread.sleep(25);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		for(int i = 0; i < 300; i++){
			IBAN nuevoIBAN = new IBAN();
			Random rand = new Random();
			int j = rand.nextInt(clientList.size());
			bank.createAccount(nuevoIBAN.toString(), j, rand.nextInt(10000));
			try {
				Thread.sleep(25);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}
}