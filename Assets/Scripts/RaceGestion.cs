using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RaceGestion : MonoBehaviour {


	// Concerne la santé du circuit
	public float maxTrackHP = 1000f;
	public float actualTrackHP;
	public GameObject HealthBar;
	private float HealthBarValue;
	public float DegradationFactor;



	// Concerne La gestion des tours
	public GameObject FinishLine;
	public GameObject MidWayCheckpoint;
	private bool wentThroughCheckpoint;
	public float MaxLapCount;
	public float ActualLapCount;




	void Start () 
	{
		actualTrackHP = maxTrackHP;
		HealthBarValue = 1f;

		wentThroughCheckpoint = false;
		ActualLapCount = 1;
	}
	
	// Update is called once per frame
	void Update ()
	{
		HealthCircuitGestion ();



	}



	void HealthCircuitGestion()
	{
		if(GetComponent<DumbXboxControl> ().lastPickup == 75) // eolien
		{
			DegradationFactor = -1;
		}

		if(GetComponent<DumbXboxControl> ().lastPickup == 100) // charbon
		{
			DegradationFactor = 2;
		}

		if(GetComponent<DumbXboxControl> ().lastPickup == 150) // petrole
		{
			DegradationFactor = 4;
		}

		if(GetComponent<DumbXboxControl> ().lastPickup == 200) // uranium
		{
			DegradationFactor = 10;
		}

		if (GetComponent<DumbXboxControl> ().Trigger < 0) 
		{
			actualTrackHP = actualTrackHP - (DegradationFactor / 60);
		}

		HealthBarValue = actualTrackHP / 1000;  // 60000 = valeur/(60 frames * 1000) = valeur/1000 par seconde 

		// Le slider correspond à la valeur  
		HealthBar.GetComponent<Slider> ().value = HealthBarValue;
	}


	void LapCountGestion()
	{
		


	}

	void OnTriggerEnter(Collider other)
	{
		Debug.Log ("lalalalala");
		if (other.gameObject == FinishLine) 
		{
			if (wentThroughCheckpoint == true) 
			{
				Debug.Log ("un tour de complété");
				ActualLapCount = ActualLapCount + 1f;
				wentThroughCheckpoint = false;
			}
		} 
		else if (other.gameObject == MidWayCheckpoint) 
		{
			Debug.Log ("à mi-chemin");
			wentThroughCheckpoint = true;
		}
	}
}
