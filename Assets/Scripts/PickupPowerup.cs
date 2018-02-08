using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickupPowerup : MonoBehaviour {

//	public GameObject PowerupCharbon;
//	public GameObject PowerupPetrole;
//	public GameObject PowerupUranium;
//	public GameObject PowerupEolienne;
	public GameObject PickupGestionnaire;

	void Start () {
		
	}
	
	void Update () {
		
	}

	void OnTriggerEnter(Collider other)
	{
		if (other.tag == "PowerupCharbon") 
		{
			GetComponent<DumbXboxControl> ().lastPickup = PickupGestionnaire.GetComponent<PowerupGestion>().pickupCharbon;

			Debug.Log ("PowerupCharbon Picked up");
		} 
		else if (other.tag == "PowerupPetrole") 
		{

			GetComponent<DumbXboxControl> ().lastPickup = PickupGestionnaire.GetComponent<PowerupGestion>().pickupPetrole;

			Debug.Log ("PowerupPetrole Picked up");
		}
		else if (other.tag == "PowerupUranium") 
		{
			GetComponent<DumbXboxControl> ().lastPickup = PickupGestionnaire.GetComponent<PowerupGestion>().pickupUranium;

			Debug.Log ("PowerupUranium Picked up");
		}
		else if (other.tag == "PowerupEolienne") 
		{
			GetComponent<DumbXboxControl> ().lastPickup = PickupGestionnaire.GetComponent<PowerupGestion>().pickupEolienne;

			Debug.Log ("PowerupEolienne Picked up");
		}
	}
}
