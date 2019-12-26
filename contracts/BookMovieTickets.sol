// A sample assignment to ITPC
pragma solidity >=0.4.22 <0.6.0;

// Contract open to bokk movie tickets at window

contract BookMovieTickets {

 struct ticket {
    address owner; 
    uint numOfTickets;    
    uint[] ticketUsedPerMovie;  
  }
  struct HashTicket {
    bool paidFor;
  }
mapping (bytes32 => uint256) public ticketBooked; // Map to ticketBooked
mapping(bytes32 => HashTicket) public htickets; //hash value that sits into the blockchain as block
mapping (address => ticket) public ownerInfo; //refer struct owner address
bytes32[] public movieList; // movie list for this rquiremet count 4
uint public totalTickets; // total tickets for the show
uint public balanceTickets;  //balnce tickts for he show
uint public ticketPrice;  //tickets price per show
uint public ShowStartTime;// asper requirement 4 shows a day at any time
event TicketKey(bytes32 ticketKey); // refer to hashkey store in bytes
uint8 window; // as of now 4 windows
uint waterandPop; //for each ticket booking water bottle and popcorn as complimentary

// creation of ticket and it' arguments such as moviename,price,time,key,window

 function Ticket(uint tickets, uint ticket_Price, bytes32[] memory  movieNames) public {
    movieList = movieNames;
    totalTickets = tickets;
    balanceTickets = tickets;
    ticket_Price = ticket_Price;
    ShowStartTime = now;
    TicketKey;
    window;
  }
  function totalTicketsFor(bytes32 movie) view public returns (uint) {
    return ticketBooked[movie];
  }
  
  //Creating ticket for amovie with desired requirements
  
  function createticketFormovie(bytes32 movie, uint8 RandomnumberSelected, uint[] memory ticketUsedPerMovie) payable
  public returns(uint result) {
    require(RandomnumberSelected >= 1 && RandomnumberSelected <= 200); // generate random number betweem 1 to 200
    require(window >=1 && window <=4, "eligible to get a bottle of water and popcorn"); // mention window number from 1 - 4
    result = waterandPop;
    waterandPop+= 1;
    uint index = indexOfMovie(movie);
    require(index != uint(-1));
    // allow to buy tickets per show till ticketUsedPerMovie length reach 100
     if (ownerInfo[msg.sender].ticketUsedPerMovie.length == 0) {
      for(uint i = 0; i < ticketUsedPerMovie.length; i++) {
        ownerInfo[msg.sender].ticketUsedPerMovie.push(0);
      }
        bytes32 hash = keccak256(abi.encodePacked(msg.sender));
        htickets[hash] = HashTicket(false);
        emit TicketKey(hash); //gnerae a hash value and print the same on ticket
    }
  }
  
  //Funcion to get exchange a botle of water with soda for first 200 even number requesters from window-1
  
 function getwaterPop(uint RandomberSelected) view public returns(bool){
        uint result = RandomberSelected%2;
        require(window != 1, "Exchange of water bottle with soda should not allow");
        if(result==0)
            return true; 
        else
            return false;
    }
    
  // function to capture count of movieList    
    
 function indexOfMovie(bytes32 movie) view public returns (uint) {
    for(uint i = 0; i < movieList.length; i++) {
      if (movieList[i] == movie) {
        return i;
      }
    }
    return uint(-1);
  }
  
  //function to buy tickets
function buy() payable public returns (uint) {
    uint ticketsToBuy = msg.value / ticketPrice;
    require(ticketsToBuy <= balanceTickets);
    ownerInfo[msg.sender].owner = msg.sender;
    ownerInfo[msg.sender].numOfTickets += ticketsToBuy;
    balanceTickets -= ticketsToBuy;
    return ticketsToBuy;
   }
 function ticketSold() view public returns (uint) {    // function to get how many tickets sold
    return totalTickets - balanceTickets;
   }
 function ownerDetails(address user) view public returns (uint, uint[] memory) { //to get owner details
    return (ownerInfo[user].numOfTickets, ownerInfo[user].ticketUsedPerMovie);
   }
 function transferTo(address payable account) public { // to get transfer ethers from payee account
    account.transfer(address(this).balance);
  }
 function allMovies() view public returns (bytes32[] memory) { // return function capture movieList
    return movieList;
  }

}
