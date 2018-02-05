<?php

class User_View_Helper_SmartmoveApi125 extends Zend_View_Helper_Abstract

{
	 // Generates the server time
    public function getServertime(){

            $posturl = "https://smlegacygateway-integration.mysmartmove.com/LandlordApi/v2/ServerTime";
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $posturl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, Array("Content-Type: application/xml","Accept:application/xml"));
            curl_setopt($ch, CURLOPT_HTTPGET, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            $response = curl_exec($ch);
            $servertime = simplexml_load_string($response);
            $servertime = explode(".",$servertime[0]);
            $servertime =  $servertime[0];
            return $servertime;

    }
       // Generates the necessary HASH key securitytoken
    public function GetSignature( $partnerId, $SecurityKey, $servertime)
    {
        $sSig        = $partnerId . $servertime;
        $SecurityKey = mb_convert_encoding($SecurityKey, "UTF8");
        return mb_convert_encoding(hash_hmac("sha1", $sSig, $SecurityKey, true), "BASE64");
    }

    public function getState(){
    $states_arr  = array('AL'=>"Alabama",'AK'=>"Alaska",'AZ'=>"Arizona",'AR'=>"Arkansas",'CA'=>"California",'CO'=>"Colorado",'CT'=>"Connecticut",'DE'=>"Delaware",'FL'=>"Florida",'GA'=>"Georgia",'HI'=>"Hawaii",'ID'=>"Idaho",'IL'=>"Illinois", 'IN'=>"Indiana", 'IA'=>"Iowa",  'KS'=>"Kansas",'KY'=>"Kentucky",'LA'=>"Louisiana",'ME'=>"Maine",'MD'=>"Maryland", 'MA'=>"Massachusetts",'MI'=>"Michigan",'MN'=>"Minnesota",'MS'=>"Mississippi",'MO'=>"Missouri",'MT'=>"Montana",'NE'=>"Nebraska",'NV'=>"Nevada",'NH'=>"New Hampshire",'NJ'=>"New Jersey",'NM'=>"New Mexico",'NY'=>"New York",'NC'=>"North Carolina",'ND'=>"North Dakota",'OH'=>"Ohio",'OK'=>"Oklahoma", 'OR'=>"Oregon",'PA'=>"Pennsylvania",'RI'=>"Rhode Island",'SC'=>"South Carolina",'SD'=>"South Dakota",'TN'=>"Tennessee",'TX'=>"Texas",'UT'=>"Utah",'VT'=>"Vermont",'VA'=>"Virginia",'WA'=>"Washington",'DC'=>"Washington D.C.",'WV'=>"West Virginia",'WI'=>"Wisconsin",'WY'=>"Wyoming");
    return  $states_arr;
    }
    public function getPropertyQuestionArray(){

        $smartmoveapiquestions_table      =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user');
        $smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user');
        $smartmoveQuestionsData           =  $smartmoveapiquestions_table->fetchAll($smartmoveapiquestions_table->select());
        $resultData                       =  array();
        $questionData                     =  array();

        foreach($smartmoveQuestionsData as $question){

            $tmpAnswerInfo      =   array();
            $questionData[0]['QuestionId']          = $question->qid;
            $questionData[0]['QuestionText']        = $question->qtext;
            $smartmoveapiquestionAnswerData         = $smartmoveapiquestionAnswer_table->fetchAll($smartmoveapiquestionAnswer_table->select()->where('qid = ?', $question->qid));

            foreach($smartmoveapiquestionAnswerData as $answer){
                        $answerInfo =   array(
                                            'AnswerText'=>$answer->answer_text,
                                            'AnswerDescription'=> $answer->answer_description
                                            );
                        $tmpAnswerInfo[]    =   $answerInfo;
            }
            $questionData[0]['SelectedAnswer']      = $question->selected_answer;
            $questionData[0]['Options']             = $tmpAnswerInfo;
            $resultData = array_merge($resultData,$questionData);
        }
        return $resultData;
    }
    
    public function createproperty($params){
		$servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/LandlordApi/v2/Property";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $response = curl_exec($ch);
        return $response = curl_exec($ch);	
		
	}
	
	public function createrenter($params){
		$servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/Renter";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $response = curl_exec($ch); 
        return $response;
	}
	public function createapplication($params){
		$servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/LandlordApi/v2/Application";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        return $response = curl_exec($ch);

	}
	    public function AcceptApplicationRenterStatus($email,$applicationId){

        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/ApplicationRenterStatus/Accept?email=$email&applicationId=$applicationId";

        $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $posturl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            curl_setopt($ch, CURLOPT_HEADER, 1);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
            curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            return $response = curl_exec($ch);
   }
       public function getApplicationStatus($email,$applicationId){
		   
        $servertime     = $this->getServertime();
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[]       = 'Content-type: application/json';
        $header[]       = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl        = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/ApplicationRenterStatus?email=$email&applicationId=$applicationId";

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        return $response = curl_exec($ch);

    }
    public function ExamRetrieve($params){

        $servertime     = $this->getServertime();
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[]       = 'Content-type: application/json';
        $header[]       = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl        = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/Exam/Retrieve";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $response = curl_exec($ch); //print_r($response); exit("11");
        return $response = curl_exec($ch);
   }
   public function createReport($email,$applicationId){

        $servertime     = $this->getServertime();
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[]       = 'Content-type: application/json';
        $header[]       = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl        = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/Report?email=$email&applicationId=$applicationId";
        $ch             = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        return $response = curl_exec($ch);
    }
     public function evaluateExam($examResponse,$email,$applicationId){

        $servertime     = $this->getServertime();
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[]       = 'Content-type: application/json';
        $header[]       = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl        = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/Exam/Evaluate?email=$email&applicationId=$applicationId";
        $ch       = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $examResponse);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        return $response = curl_exec($ch);

    }
    public function getApplication($applicationId){

        $servertime     = $this->getServertime();
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[]       = 'Content-type: application/json';
        $header[]       = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl        = "https://smlegacygateway-integration.mysmartmove.com/LandlordApi/v2/Application/$applicationId";
        $ch             = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        return $response = curl_exec($ch);

        }
        public function updaterenter($params){
		$servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/RenterApi/v2/Renter";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $posturl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        $response = curl_exec($ch);
        return $response;
	}
	
	public function updateproperty($params){
		
        $servertime     = $this->getServertime();
		$partnerId      = 125;
        $SecurityKey    ='3dEf7KJDZNiw7HlrCrBqsu/2Ywgd8QPAodIXhqsclm3mTrma+cLK/gheqmey92j94zf9jUQQG5vTZfRY9zyvdA==';
        $securityToken  = $this->GetSignature($partnerId, $SecurityKey, $servertime);
        $header         = array();
        $header[] = 'Content-type: application/json';
        $header[] = 'Authorization: smartmovepartner partnerId="'.$partnerId.'",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
        $posturl  = "https://smlegacygateway-integration.mysmartmove.com/LandLordApi/v2/Property";
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $posturl);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
		curl_setopt($ch, CURLOPT_HEADER, 1);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
		curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		$response = curl_exec($ch);
		return $response;
		
	}
	public function getStripeFiles(){
            //dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'
            //echo dirname($_SERVER['SCRIPT_FILENAME']); exit;
            //echo dirname(__FILE__); exit;
            if (!function_exists('curl_init')) {
              throw new Exception('Stripe needs the CURL PHP extension.');
            }
            if (!function_exists('json_decode')) {
              throw new Exception('Stripe needs the JSON PHP extension.');
            }
            if (!function_exists('mb_detect_encoding')) {
              throw new Exception('Stripe needs the Multibyte String PHP extension.');
            }

            // Stripe singleton
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Stripe.php');

            // Utilities
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Util.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Util/Set.php');

            // Errors
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Error.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApiError.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApiConnectionError.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/AuthenticationError.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/CardError.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/InvalidRequestError.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/RateLimitError.php');

            // Plumbing
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Object.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApiRequestor.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApiResource.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/SingletonApiResource.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/AttachedObject.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/List.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/RequestOptions.php');

            // Stripe API Resources
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Account.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Card.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Balance.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/BalanceTransaction.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Charge.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Customer.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/FileUpload.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Invoice.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/InvoiceItem.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Plan.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Subscription.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Token.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Coupon.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Event.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Transfer.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Recipient.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/Refund.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApplicationFee.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/ApplicationFeeRefund.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/BitcoinReceiver.php');
            require(dirname($_SERVER['SCRIPT_FILENAME']) . '/Stripe/BitcoinTransaction.php');
        }
}
